import { FC, useEffect, useMemo } from 'react'

import {
	useTable,
	useSortBy,
	Column,
	TableOptions,
	UseSortByColumnProps
} from 'react-table'

import {
	chakra,
	Spinner,
	Box,
	Accordion,
	AccordionItem,
	AccordionButton,
	AccordionPanel,
	AccordionIcon,
	Table,
	Thead,
	Tbody,
	// Tfoot,
	Tr,
	Th,
	Td,
	Button
} from '@chakra-ui/react'

import { TriangleUpIcon, TriangleDownIcon } from '@chakra-ui/icons'

// import { Route } from '@/schema/typed'
import {
	useDataQuery,
	useSimulateUpMutation,
	useSimulateDownMutation
} from '@/schema'

// function DataTable <Data>({data: TableOptions<Data>}) {}
const DataTable: FC<{ title: string; data: TableOptions<object> }> = ({
	title,
	data
}) => {
	const { getTableProps, getTableBodyProps, headerGroups, rows, prepareRow } =
		useTable(data, useSortBy)

	return (
		<AccordionItem>
			<h2>
				<AccordionButton>
					<Box flex='1' textAlign='left'>
						{title}
					</Box>
					<AccordionIcon />
				</AccordionButton>
			</h2>
			<AccordionPanel>
				<Table size='sm' {...getTableProps()}>
					<Thead>
						{headerGroups.map(headerGroup => (
							<Tr {...headerGroup.getHeaderGroupProps()}>
								{headerGroup.headers.map(column => (
									<Th
										{...column.getHeaderProps(
											(
												column as unknown as UseSortByColumnProps<object>
											).getSortByToggleProps()
										)}
										isNumeric={(column as any).isNumeric}
									>
										{column.render('Header')}
										<chakra.span pl='4'>
											{(
												column as unknown as UseSortByColumnProps<object>
											).isSorted ? (
												(
													column as unknown as UseSortByColumnProps<object>
												).isSortedDesc ? (
													<TriangleDownIcon aria-label='sorted descending' />
												) : (
													<TriangleUpIcon aria-label='sorted ascending' />
												)
											) : null}
										</chakra.span>
									</Th>
								))}
							</Tr>
						))}
					</Thead>
					<Tbody {...getTableBodyProps()}>
						{rows.map(row => {
							prepareRow(row)
							return (
								<Tr {...row.getRowProps()}>
									{row.cells.map(cell => (
										<Td
											{...cell.getCellProps()}
											isNumeric={
												(cell.column as any).isNumeric
											}
										>
											{cell.render('Cell')}
										</Td>
									))}
								</Tr>
							)
						})}
					</Tbody>
				</Table>
			</AccordionPanel>
		</AccordionItem>
	)
}

export const Data: FC = () => {
	const [{ data, fetching, error }, getData] = useDataQuery()
	const [_simulateUpValue, simulateUp] = useSimulateUpMutation()
	const [_simulateDownValue, simulateDown] = useSimulateDownMutation()

	useEffect(() => {
		if (!data && !fetching && !error) getData()
	}, [data, fetching, error, getData])

	const routeColumns: Column[] = useMemo(
		() => [
			// { Header: 'id', accessor: 'id' },
			{ Header: 'from', accessor: 'from.name' },
			{ Header: 'to', accessor: 'to.name' },
			{
				Header: 'duration',
				Cell: ({ value }) => `${value / 60}h.`,
				accessor: 'duration'
			}
		],
		[]
	)

	const flightColumns: Column[] = useMemo(
		() => [
			// { Header: 'id', accessor: 'id' },
			{ Header: 'plane', accessor: 'plane.code' },
			{ Header: 'route from', accessor: 'route.from.name' },
			{ Header: 'route to', accessor: 'route.to.name' },
			{
				Header: 'duration',
				Cell: ({ value }) => `${value / 60}h.`,
				accessor: 'route.duration'
			}
		],
		[]
	)

	return (
		<>
			<Button
				colorScheme='primary'
				m={4}
				onClick={() => simulateUp({}).then(() => getData())}
			>
				Simulate Up
			</Button>
			<Button
				colorScheme='primary'
				m={4}
				onClick={() => simulateDown().then(() => getData())}
			>
				Simulate Down
			</Button>
			{fetching && <Spinner margin='auto' size='xl' />}
			{data && (
				<Box width={'100%'} overflowX={'scroll'}>
					<Accordion minWidth={'max-content'}>
						<DataTable
							title={'Routes'}
							data={{ columns: routeColumns, data: data.routes }}
						/>
						<DataTable
							title={'Flights'}
							data={{
								columns: flightColumns,
								data: data.flights
							}}
						/>
					</Accordion>
				</Box>
			)}
		</>
	)
}

export default Data
