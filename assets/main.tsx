import { StrictMode } from 'react'
import { render } from 'react-dom'
import 'virtual:windi.css'
import 'virtual:windi-devtools'
import '@hookstate/devtools'

import '@/favicon.svg'

import App from '@/components/App'

render(
	<StrictMode>
		<App />
	</StrictMode>,
	document.getElementById('root')
)
