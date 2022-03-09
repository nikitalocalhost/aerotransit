import { FC } from 'react'
import { Redirect } from 'wouter'
import { StatusCodes } from 'http-status-codes'
import { useAuth } from './useAuth'

export const AuthGuard: FC<{ priveleges?: string[] }> = ({
	priveleges = [],
	children
}) => {
	const { user, hasPriveleges } = useAuth()

	return hasPriveleges(priveleges) ? (
		<>{children}</>
	) : (
		<Redirect
			to={`/error/${
				user ? StatusCodes.FORBIDDEN : StatusCodes.UNAUTHORIZED
			}`}
		/>
	)
}

export default AuthGuard
