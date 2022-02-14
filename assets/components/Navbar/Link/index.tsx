import { FC } from 'react'
import { Link as WLink, useRoute } from 'wouter'
import clsx from 'clsx'

import styles from './Link.module.css'

export const Link: FC<{ href: string }> = ({ href, children }) => {
	const [isActive] = useRoute(href)

	return (
		<WLink href={href}>
			<a className={clsx(styles.link, isActive && styles.active)}>
				{children}
			</a>
		</WLink>
	)
}
