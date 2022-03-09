import { FC } from 'react'
import { Switch, Route, Redirect } from 'wouter'

import { AuthGuard } from '@/lib/auth'

import Login from './Login'
import Logout from './Logout'
import Profile from './Profile'

export const Routes: FC<{ base: string }> = ({ base }) => {
	return (
		<>
			<Switch>
				<Route path={`${base}`}>Hello!</Route>

				<Route path={`${base}/login`}>
					<Login />
				</Route>

				<Route path={`${base}/profile`}>
					<AuthGuard>
						<Profile />
					</AuthGuard>
				</Route>

				<Route path={`${base}/logout`}>
					<AuthGuard>
						<Logout />
					</AuthGuard>
				</Route>

				<Route>
					<Redirect to='/error/404' />
				</Route>
			</Switch>
		</>
	)
}

export default Routes
