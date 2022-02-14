import { FC } from 'react'

import Provider from './provider'
import View from './view'

export const App: FC = () => {
	return (
		<Provider>
			<View />
		</Provider>
	)
}

export default App
