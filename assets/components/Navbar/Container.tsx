import { FC } from 'react'

import { Flex, FlexProps } from '@chakra-ui/react'

export const Container: FC<FlexProps> = ({ children, ...props }) => (
	<Flex
		as='nav'
		align='center'
		justify='space-between'
		wrap='wrap'
		w='100%'
		mb={12}
		p={6}
		// bg={['primary.500', 'primary.500', 'transparent', 'transparent']}
		bg={'primary.500'}
		color={['white', 'white', 'primary.700', 'primary.700']}
		{...props}
	>
		{children}
	</Flex>
)
