import { FC } from 'react'

import { Container } from '@chakra-ui/react'

import Navbar from '@/components/Navbar'

import Routes from './routes'

import Provider from './provider'

export const App: FC = () => {
	return (
		<Provider>
			<Navbar />
			<Container maxW='container.lg'>
				<Routes />
			</Container>
		</Provider>
	)
}

export default App
