import { FC } from 'react'

import { useRoute, useLocation } from 'wouter'

import {
	Menu,
	MenuButton,
	MenuList,
	MenuItem,
	Button,
	Text
} from '@chakra-ui/react'

import { ChevronDownIcon } from '@chakra-ui/icons'

import { User } from '@/schema'

import { useAuth } from '@/lib/auth'

import { Link } from './Link'

const UserMenuItem: FC<{ to: string }> = ({ to, children }) => {
	const [isActive] = useRoute(to)
	const [_location, setLocation] = useLocation()

	return (
		<MenuItem onClick={() => setLocation(to)}>
			<Text
				colorScheme='primary'
				textDecoration={isActive ? 'underline' : ''}
			>
				{children}
			</Text>
		</MenuItem>
	)
}

const UserMenu: FC<{ user: User }> = ({ user }) => (
	<Menu>
		<MenuButton
			colorScheme='primary'
			borderWidth={1}
			as={Button}
			rightIcon={<ChevronDownIcon />}
		>
			Hello, {user.username}!
		</MenuButton>
		<MenuList color='black'>
			<UserMenuItem to='/user/profile'>Profile</UserMenuItem>
			<UserMenuItem to='/user/logout'>Logout</UserMenuItem>
		</MenuList>
	</Menu>
)

export const Auth: FC = () => {
	const { user } = useAuth()
	return !user ? (
		<Link to='/user/login'>Login</Link>
	) : (
		<UserMenu user={user} />
	)
}
