import { FC } from 'react'
import { Provider as UrqlProvider } from 'urql'

import { ChakraProvider, CSSReset } from '@chakra-ui/react'

import { client } from '@/lib/urql'
import { theme } from '@/lib/theme'

import ErrorBoundary from '@/components/ErrorBoundary'

export const AppProvider: FC = ({ children }) => {
	return (
		<>
			<UrqlProvider value={client}>
				<CSSReset />
				<ChakraProvider theme={theme}>
					<ErrorBoundary>{children}</ErrorBoundary>
				</ChakraProvider>
			</UrqlProvider>
		</>
	)
}

export default AppProvider
