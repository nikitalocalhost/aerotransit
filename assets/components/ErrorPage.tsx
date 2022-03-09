import { FC } from 'react'

import { getReasonPhrase } from 'http-status-codes'

import { isString } from '@chakra-ui/utils'
import { Heading, Text } from '@chakra-ui/react'

const tryGettingReasonPhrase = (x: number | string): string | undefined => {
	if (isString(x)) {
		try {
			const n = parseInt(x)
			return getReasonPhrase(n)
		} catch (e) {
			console.trace(e)
		}
		try {
			return getReasonPhrase(x)
		} catch (e) {
			console.trace(e)
		}
	} else {
		try {
			return getReasonPhrase(x)
		} catch (e) {
			console.trace(e)
		}
	}
	return undefined
}

export const ErrorPage: FC<{ error: string }> = ({ error }) => {
	const reasonPhrase = tryGettingReasonPhrase(error)
	return (
		<>
			<Heading mb={4}>Error {error}</Heading>
			<Text>{reasonPhrase ?? reasonPhrase}</Text>
		</>
	)
}

export default ErrorPage
