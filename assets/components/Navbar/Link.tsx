import { FC } from 'react'
import { Link as RouterLink, useRoute } from 'wouter'

import {
	Link as StyleLink,
	LinkProps as StyleLinkProps
	// Text,
	// TextProps
} from '@chakra-ui/react'

interface LinkProps extends StyleLinkProps {
	to: string
}

export const Link: FC<LinkProps> = ({ to, children, ...params }) => {
	const [isActive] = useRoute(to)

	return (
		<RouterLink href={to}>
			<StyleLink
				display='block'
				textDecoration={isActive ? 'underline' : ''}
				{...params}
			>
				{children}
			</StyleLink>
		</RouterLink>
	)
}
