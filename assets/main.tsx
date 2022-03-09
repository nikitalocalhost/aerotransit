import { StrictMode } from 'react'
import { render } from 'react-dom'
import '@hookstate/devtools'

import App from '@/components/App'

render(
	<StrictMode>
		<App />
	</StrictMode>,
	document.getElementById('root')
)
