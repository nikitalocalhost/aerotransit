import { useState, FC } from 'react'

import { Box, Stack } from '@chakra-ui/react'

import { MenuToggle } from './MenuToggle'

import { Container } from './Container'
import { Logo } from './Logo'
import { Link } from './Link'
import { Auth } from './Auth'

export const Navbar: FC = () => {
	const [isOpen, setOpen] = useState(false)

	const toggleOpen = () => setOpen(!isOpen)

	return (
		<Container backgroundColor={'primary'} color={'white'}>
			<Logo />
			<MenuToggle toggle={toggleOpen} isOpen={isOpen} />

			<Box
				display={{ base: isOpen ? 'block' : 'none', md: 'block' }}
				flexBasis={{ base: '100%', md: 'auto' }}
			>
				<Stack
					spacing={8}
					align='center'
					justify={[
						'center',
						'space-between',
						'flex-end',
						'flex-end'
					]}
					direction={['column', 'row', 'row', 'row']}
					pt={[4, 4, 0, 0]}
				>
					<Link to='/data'>Data</Link>
					<Auth />
				</Stack>
			</Box>
		</Container>
	)
}

export default Navbar
