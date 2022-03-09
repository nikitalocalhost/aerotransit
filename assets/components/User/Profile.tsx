import { FC } from 'react'

import { Box, Heading, Text } from '@chakra-ui/react'
import { useAuth } from '@/lib/auth'

export const Profile: FC = () => {
	const { user } = useAuth()

	if (!user) throw new Error('User is null')

	return (
		<Box>
			<Heading mb={6}>Profile</Heading>
			<Text mb={2}>
				Username: <Text display={'inline'}>{user.username}</Text>
			</Text>
			<Text>
				Role: <Text display={'inline'}>{user.role.name}</Text>
			</Text>
		</Box>
	)
}

export default Profile
