import { FC } from 'react'

import { Box } from '@chakra-ui/react'
import { CloseIcon, HamburgerIcon as MenuIcon } from '@chakra-ui/icons'

export const MenuToggle: FC<{ toggle: () => void; isOpen: boolean }> = ({
	toggle,
	isOpen
}) => {
	return (
		<Box display={{ base: 'block', md: 'none' }} onClick={toggle}>
			{isOpen ? <CloseIcon /> : <MenuIcon />}
		</Box>
	)
}

export default MenuToggle
