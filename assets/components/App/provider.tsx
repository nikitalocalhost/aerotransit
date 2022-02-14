import { FC } from 'react'
import { Provider as UrqlProvider } from 'urql'
import { Router as RootRouter } from 'wouter'

import { client } from '@/lib/urql'

export const AppProvider: FC = ({ children }) => {
	return (
		<UrqlProvider value={client}>
			<RootRouter base=''>{children}</RootRouter>
		</UrqlProvider>
	)
}

export default AppProvider
