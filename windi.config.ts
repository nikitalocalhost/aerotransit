import { defineConfig } from 'windicss/helpers'

import filtersPlugin from 'windicss/plugin/filters'
import formsPlugin from 'windicss/plugin/forms'
import aspectRatioPlugin from 'windicss/plugin/aspect-ratio'
import lineClampPlugin from 'windicss/plugin/line-clamp'
import typographyPlugin from 'windicss/plugin/typography'

export default defineConfig({
	darkMode: 'class',
	plugins: [
		filtersPlugin,
		formsPlugin,
		aspectRatioPlugin,
		lineClampPlugin,
		typographyPlugin
	],
	extract: {
		include: ['./assets/**/*.{vue,jsx,tsx,svelte,css}']
	}
})
