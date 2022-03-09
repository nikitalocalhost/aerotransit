import { FC } from 'react'
import { ErrorBoundary as EB, FallbackProps } from 'react-error-boundary'

import { useLocation } from 'wouter'

import {
	Container,
	Heading,
	Text,
	Code,
	Button,
	useClipboard
} from '@chakra-ui/react'

const stringifyError = (error: Error) =>
	JSON.stringify(error, Object.getOwnPropertyNames(error), 0)

const ErrorFallback: FC<FallbackProps> = ({ error }) => {
	const [location, _useLocation] = useLocation()

	const errorStatus = `{"error": ${stringifyError(
		error
	)}, "globalState": {"location": "${location}", }}`

	const { hasCopied, onCopy } = useClipboard(errorStatus)

	return (
		<Container m={4}>
			<Heading>Oh oh...</Heading>
			<Text>Something went wrong...</Text>
			<Text mb={4}>
				Error message: <Code>{error.message}</Code>
			</Text>
			<Code
				mb={2}
				maxWidth='100%'
				height='10rem'
				overflow={'scroll'}
				overflowX={'clip'}
			>
				{errorStatus}
			</Code>
			<Button onClick={onCopy} isDisabled={hasCopied}>
				{!hasCopied ? 'Copy' : 'Now you can paste it!'}
			</Button>
		</Container>
	)
}

export const ErrorBoundary: FC = ({ children }) => {
	return <EB FallbackComponent={ErrorFallback}>{children}</EB>
}

export default ErrorBoundary
