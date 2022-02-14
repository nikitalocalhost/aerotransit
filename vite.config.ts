import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tsconfigPaths from 'vite-tsconfig-paths'
import windicss from 'vite-plugin-windicss'

// https://vitejs.dev/config/
export default defineConfig(({ command }) => {
	const isDev = command !== 'build'
	if (isDev) {
		// Terminate the watcher when Phoenix quits
		process.stdin.on('close', () => {
			process.exit(0)
		})

		process.stdin.resume()
	}

	return {
		plugins: [tsconfigPaths(), windicss(), react()],
		publicDir: 'static',
		build: {
			target: 'esnext',
			outDir: 'priv/static/assets',
			emptyOutDir: true,
			sourcemap: isDev,
			manifest: false,
			rollupOptions: {
				input: {
					main: 'assets/main.tsx'
				},
				output: {
					entryFileNames: '[name].js',
					chunkFileNames: '[name].js',
					assetFileNames: '[name][extname]'
				}
			}
		}
	}
})
