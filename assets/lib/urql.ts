import { make, pipe, toObservable } from 'wonka'
import { Channel, Socket, SocketConnectOption } from 'phoenix'

import {
	Exchange,
	subscriptionExchange,
	createClient,
	dedupExchange,
	cacheExchange,
	fetchExchange
} from 'urql'

const SERVER_URL =
	import.meta.env.SERVER_URL || `${location.protocol}//${location.host}/`

import { multipartFetchExchange } from '@urql/exchange-multipart-fetch'
import { authExchange } from '@/lib/auth'

const ENDPOINT_PATH = '/api/graphql'
const SOCKET_PATH = '/socket'

const getAbsintheExchange = (
	endpoint: string,
	socketOptions: Partial<SocketConnectOption> | undefined = {}
): Exchange => {
	const socket = new Socket(endpoint, socketOptions)

	socket.connect()
	const absintheChannel = socket.channel('__absinthe__:control')
	absintheChannel.join()

	const absintheExchange = subscriptionExchange({
		forwardSubscription({ query, variables }) {
			let subscriptionChannel: Channel | undefined

			const source = make(observer => {
				const { next } = observer

				absintheChannel
					.push('doc', { query, variables })
					.receive('ok', v => {
						const subscriptionId = v.subscriptionId

						if (subscriptionId) {
							subscriptionChannel = socket.channel(subscriptionId)
							subscriptionChannel.on(
								'subscription:data',
								value => {
									next(value.result)
								}
							)
						}
					})

				return () => {
					subscriptionChannel?.leave()
				}
			})

			return pipe(source, toObservable)
		}
	})

	return absintheExchange
}

const endpoint = new URL(ENDPOINT_PATH, SERVER_URL).toString()
const socket = (() => {
	const socket = new URL(SOCKET_PATH, SERVER_URL)
	socket.protocol = socket.protocol === 'https:' ? 'wss:' : 'ws:'
	return socket.toString()
})()

export const client = createClient({
	url: endpoint,
	exchanges: [
		dedupExchange,
		cacheExchange,
		authExchange,
		multipartFetchExchange,
		fetchExchange,
		getAbsintheExchange(socket)
	]
})

export default client
