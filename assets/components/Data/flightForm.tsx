import { FC, useEffect } from 'react'

import { useForm, SubmitHandler } from 'react-hook-form'

import {
	Box,
	Heading,
	FormErrorMessage,
	FormLabel,
	FormControl,
	Select,
	// Input,
	Button,
	Modal,
	ModalOverlay,
	ModalContent,
	ModalHeader,
	ModalFooter,
	// ModalBody,
	ModalCloseButton,
	useDisclosure
} from '@chakra-ui/react'

import {
	useDataQuery,
	useCreateFlightMutation,
	CreateFlightMutationVariables
} from '@/schema'

export const FlightForm: FC = () => {
	const {
		handleSubmit,
		register,
		formState: { errors, isSubmitting },
		reset
	} = useForm<CreateFlightMutationVariables>({})

	const [{ data, fetching, error }, getData] = useDataQuery()

	const [_flight, createFlight] = useCreateFlightMutation()

	const { isOpen, onOpen, onClose } = useDisclosure()

	useEffect(() => {
		if (!data && !fetching && !error) getData()
	}, [data, fetching, error, getData])

	const isInvalid = !!errors.planeId || !!errors.routeId

	const onSubmit: SubmitHandler<CreateFlightMutationVariables> = async ({
		routeId,
		planeId
	}) => {
		const _flight = await createFlight({ routeId, planeId })
		onOpen()
		reset()
	}

	return (
		<>
			<Box p={4} borderWidth={1} borderRadius='lg' shadow={'lg'}>
				<form onSubmit={handleSubmit(onSubmit)}>
					<Heading mb={6}>Create Flight</Heading>
					<FormControl isInvalid={isInvalid}>
						<Box mb={4}>
							<FormLabel htmlFor='planeId'>Plane</FormLabel>
							<Select
								id='planeId'
								placeholder='Plane'
								{...register('planeId', {
									required: 'This is required'
								})}
							>
								{data?.planes.map((plane, idx) => (
									<option key={idx} value={plane.id}>
										{plane.company.name}: {plane.code}
									</option>
								))}
							</Select>
							<FormErrorMessage>
								{errors.planeId && errors.planeId.message}
							</FormErrorMessage>
						</Box>

						<Box mb={4}>
							<FormLabel htmlFor='routeId'>Route</FormLabel>
							<Select
								id='routeId'
								placeholder='Route'
								{...register('routeId', {
									required: 'This is required'
								})}
							>
								{data?.routes.map((route, idx) => (
									<option key={idx} value={route.id}>
										{route.from.name} - {route.to.name} -{' '}
										{route.duration / 60}h.
									</option>
								))}
							</Select>
							<FormErrorMessage>
								{errors.routeId && errors.routeId.message}
							</FormErrorMessage>
						</Box>
					</FormControl>

					<Box mt={4}>
						<Button
							colorScheme='primary'
							isLoading={isSubmitting}
							type='submit'
						>
							Create
						</Button>
						<Button
							ml={4}
							colorScheme='primary'
							onClick={() => reset()}
						>
							Reset
						</Button>
					</Box>
				</form>
			</Box>
			<Modal isOpen={isOpen} onClose={onClose}>
				<ModalOverlay />
				<ModalContent>
					<ModalHeader>Flight created!</ModalHeader>
					<ModalCloseButton />
					{/* <ModalBody>
						<Lorem count={2} />
					</ModalBody> */}

					<ModalFooter>
						<Button colorScheme='primary' mr={3} onClick={onClose}>
							Close
						</Button>
					</ModalFooter>
				</ModalContent>
			</Modal>
		</>
	)
}

export default FlightForm
