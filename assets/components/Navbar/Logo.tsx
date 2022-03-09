import { FC } from 'react'
import { Box, BoxProps, Link as StyledLink, Text } from '@chakra-ui/react'
import { Link } from 'wouter'

export const Logo: FC<BoxProps> = props => {
	return (
		<Link to={'/'}>
			<StyledLink>
				<Box {...props}>
					<Text fontSize='lg' fontWeight='bold'>
						AEROTRANSIT
					</Text>
				</Box>
			</StyledLink>
		</Link>
	)
}

export default Logo
