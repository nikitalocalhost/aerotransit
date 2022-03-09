// import '@fontsource/raleway'
// import '@fontsource/roboto-slab'

import {
	extendTheme,
	theme as baseTheme,
	withDefaultColorScheme
} from '@chakra-ui/react'

export const theme = extendTheme(
	{
		colors: {
			primary: baseTheme.colors.teal
		}
		// fonts: {
		// 	heading: 'Roboto Slab, sans-serif',
		// 	body: 'Raleway, sans-serif'
		// }
	},
	withDefaultColorScheme({ colorScheme: 'facebook' })
)
