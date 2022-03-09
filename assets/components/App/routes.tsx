import { FC } from 'react'
import { Switch, Route, Redirect } from 'wouter'

import { AuthGuard } from '@/lib/auth'

import User from '@/components/User'
import Data from '@/components/Data'
import FlightForm from '@/components/Data/flightForm'

import ErrorPage from '@/components/ErrorPage'

export const Routes: FC = () => {
	return (
		<>
			<Switch>
				<Route path='/'>Hello!</Route>

				<Route path='/protected'>
					<AuthGuard priveleges={['read_all']}>
						Hello from protected!
					</AuthGuard>
				</Route>

				<Route path='/data'>
					<AuthGuard priveleges={['read_all']}>
						<Data />
					</AuthGuard>
				</Route>

				<Route path='/data/flight'>
					<AuthGuard priveleges={['read_all', 'write_all']}>
						<FlightForm />
					</AuthGuard>
				</Route>

				<Route path='/user/:all*'>
					<User base='/user' />
				</Route>

				<Route path='/error/:error'>
					{({ error }) => <ErrorPage error={error} />}
				</Route>

				<Route>
					<Redirect to='/error/404' />
				</Route>
			</Switch>
		</>
	)
}

export default Routes
