import { FC } from 'react'
import { Router as WR, useLocation, useRouter } from 'wouter'

export const Router: FC<{ base: string }> = ({ base, children }) => {
	const router = useRouter()
	const [location] = useLocation()
	const nestedBase = `${router.base}${base}`

	// don't render anything outside of the scope
	if (!location.startsWith(nestedBase)) return null

	// we need key to make sure the router will remount when base changed
	return (
		<WR base={nestedBase} key={nestedBase}>
			{children}
		</WR>
	)
}
