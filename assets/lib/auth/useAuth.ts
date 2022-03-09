import { useState } from '@hookstate/core'

import { useLoginMutation } from '@/schema'

import { authState } from './state'

export const useAuth = () => {
	const state = useState(authState)
	const [_loginResult, loginMutation] = useLoginMutation()

	const data = state.get()

	const isAuth = !!data
	const user = data?.user
	const hasPrivelege = (privelege: string) => {
		if (!user) return false
		if (user.role.priveleges.findIndex(x => x === privelege) === -1)
			return false
		return true
	}
	const hasPriveleges = (priveleges: string[]) => {
		if (!user) return false
		const arrayTrue = (a: boolean[]) => a.findIndex(x => x === false) === -1
		return arrayTrue(priveleges.map(hasPrivelege))
	}
	const logout = async () => state.set(null)
	const login = async (auth: { username: string; password: string }) => {
		const result = await loginMutation({ ...auth })
		if (!result.data) {
			return
		}
		state.set(result.data.authorize || null)
		return result.data.authorize
	}

	return { isAuth, user, hasPrivelege, hasPriveleges, login, logout }
}
