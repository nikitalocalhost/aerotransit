import { FC } from 'react'

import { Link } from './Link'

import styles from './style.module.css'

export const Navbar: FC = () => {
	return (
		<div className={styles.navbar}>
			<img className={styles.logo} src='/static/logo.png'></img>
			<h1>Hello! From NAVBAR</h1>
			<Link href='/'>Home</Link>
			<Link href='/about'>About</Link>
		</div>
	)
}

export default Navbar
