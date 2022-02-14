import jwt, { JwtPayload } from 'jwt-decode'
import { gql, makeOperation } from '@urql/core'
import { authExchange as genAuthExchange } from '@urql/exchange-auth'

import { createState, useState } from '@hookstate/core'
import { Persistence } from '@hookstate/persistence'
import { useMutation } from 'urql'

import { Nullable } from '@/lib/shared'

export type AuthState = { token: string; refreshToken: string }

const authState = createState<AuthState | null>(null)
authState.attach(Persistence('auth'))

const LOGIN_MUTATION = gql<
	{ login: AuthState },
	{ login: { username: string; password: string } }
>`
	mutation ($username: string, $password: string) {
		login(user: { username: $username, password: $password }) {
			token
			refreshToken
		}
	}
`

const REFRESH_MUTATION = gql<
	{ refreshToken: AuthState },
	{ refreshToken: string }
>`
	mutation ($refreshToken: string) {
		refreshToken(refreshToken: $refreshToken) {
			token
			refreshToken
		}
	}
`

const isAuthState = (
	auth:
		| AuthState
		| Nullable<AuthState>
		| Partial<AuthState>
		| Nullable<Partial<AuthState>>
		| null
		| undefined
): auth is AuthState => {
	if (!auth) return false
	if (!auth.token) return false
	if (!auth.refreshToken) return false
	return true
}

const isJwtTokenValid = (token: string): boolean => {
	try {
		const header = jwt<JwtPayload>(token)
		if (!header.exp) return false
		if (Date.now() >= header.exp * 1000) return false
		return true
	} catch {
		return false
	}
}

const isAuthStateValid = (auth: AuthState): boolean => {
	return isJwtTokenValid(auth.token)
}

export const authExchange = genAuthExchange<AuthState>({
	addAuthToOperation: ({ authState, operation }) => {
		if (!isAuthState(authState)) return operation

		const fetchOptions =
			typeof operation.context.fetchOptions === 'function'
				? operation.context.fetchOptions()
				: operation.context.fetchOptions || {}

		return makeOperation(operation.kind, operation, {
			...operation.context,
			fetchOptions: {
				...fetchOptions,
				headers: {
					...fetchOptions.headers,
					Authorization: authState.token
				}
			}
		})
	},
	getAuth: async ({ authState: state, mutate }) => {
		if (!state) {
			const auth = authState.get()
			if (auth) return auth
			return null
		}

		const result = await mutate(REFRESH_MUTATION, {
			refreshToken: state.refreshToken
		})

		if (!result.data?.refreshToken) {
			authState.set(null)
			return null
		}

		authState.set(result.data?.refreshToken)
		return result.data?.refreshToken
	},
	didAuthError: ({ authState: _authState, error }) => {
		return error.graphQLErrors.some(e => e.extensions?.code === 'FORBIDDEN')
	},
	willAuthError: ({ authState, operation: _operation }) => {
		if (!authState) return true
		if (!isAuthStateValid(authState)) return false

		return false
	}
})

export const useAuth = () => {
	const state = useState(authState)
	const [_loginResult, loginMutation] = useMutation(LOGIN_MUTATION)

	const isAuth = !!state.get()
	const logout = async () => state.set(null)
	const login = async (auth: { username: string; password: string }) => {
		const result = await loginMutation({ login: auth })
		if (!result.data) {
			return
		}
		state.set(result.data.login)
		return result.data.login
	}

	return { isAuth, login, logout }
}
