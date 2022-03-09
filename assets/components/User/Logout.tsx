import { FC, useEffect } from 'react'

import { useLocation } from 'wouter'

import { Box, Heading, Text } from '@chakra-ui/react'

import { useAuth } from '@/lib/auth'

export const LogOut: FC = () => {
	const { user, logout } = useAuth()
	const [_location, setLocation] = useLocation()

	useEffect(() => {
		const afterLogOut = () => setLocation('/user/login')

		if (user) {
			logout().then(afterLogOut)
		} else {
			afterLogOut()
		}
	}, [user, logout, setLocation])

	return (
		<Box>
			<Heading>You are logging out...</Heading>
			<Text>Please wait</Text>
		</Box>
	)
}

export default LogOut
