import jwt, { JwtPayload } from 'jwt-decode'
import { makeOperation } from '@urql/core'
import { authExchange as genAuthExchange } from '@urql/exchange-auth'

import { Authorize, RefreshAuthDocument } from '@/schema/typed'

import { authState } from './state'

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

const isAuthStateValid = (auth?: Authorize): boolean => {
	return !!auth && isJwtTokenValid(auth.tokens.token)
}

export const authExchange = genAuthExchange<Authorize>({
	addAuthToOperation: ({ authState, operation }) => {
		if (!authState) return operation

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
					Authorization: authState.tokens.token
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

		const result = await mutate(RefreshAuthDocument, {
			refreshToken: state.tokens.refreshToken
		})

		if (!result.data?.refreshAuth) {
			authState.set(null)
			return null
		}

		authState.merge({ tokens: result.data?.refreshAuth })
		return authState.get()
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
