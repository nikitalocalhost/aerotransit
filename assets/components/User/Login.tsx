import { FC, useEffect } from 'react'

import { useLocation } from 'wouter'

import { useForm, SubmitHandler } from 'react-hook-form'

import {
	Box,
	Heading,
	FormErrorMessage,
	FormLabel,
	FormControl,
	Input,
	Button
} from '@chakra-ui/react'

import { useAuth } from '@/lib/auth'

import { LoginMutationVariables } from '@/schema'

const REDIRECT_LOCATION = '/'

export const LogIn: FC = () => {
	const { isAuth, login } = useAuth()
	const [_location, setLocation] = useLocation()
	const {
		handleSubmit,
		register,
		formState: { errors, isSubmitting }
	} = useForm<LoginMutationVariables>({})

	const isInvalid = !!errors.username || !!errors.password

	useEffect(() => {
		if (isAuth) setLocation(REDIRECT_LOCATION)
	}, [isAuth, setLocation])

	const onSubmit: SubmitHandler<LoginMutationVariables> = async ({
		username,
		password
	}) => {
		const user = await login({ username, password })
		if (user) setLocation(REDIRECT_LOCATION)
	}

	return (
		<Box p={4} borderWidth={1} borderRadius='lg' shadow={'lg'}>
			<form onSubmit={handleSubmit(onSubmit)}>
				<Heading mb={6}>Log In</Heading>
				<FormControl isInvalid={isInvalid}>
					<Box mb={4}>
						<FormLabel htmlFor='username'>Username</FormLabel>
						<Input
							id='username'
							placeholder='Username'
							{...register('username', {
								required: 'This is required',
								minLength: {
									value: 4,
									message: 'Minimum length should be 4'
								}
							})}
						/>
						<FormErrorMessage>
							{errors.username && errors.username.message}
						</FormErrorMessage>
					</Box>

					<Box mb={4}>
						<FormLabel htmlFor='password'>Password</FormLabel>
						<Input
							id='password'
							placeholder='Password'
							type='password'
							{...register('password', {
								required: 'This is required',
								minLength: {
									value: 4,
									message: 'Minimum length should be 4'
								}
							})}
						/>
						<FormErrorMessage>
							{errors.password && errors.password.message}
						</FormErrorMessage>
					</Box>
				</FormControl>

				<Button
					mt={4}
					colorScheme='primary'
					isLoading={isSubmitting}
					type='submit'
				>
					Log In
				</Button>
			</form>
		</Box>
	)
}

export default LogIn
