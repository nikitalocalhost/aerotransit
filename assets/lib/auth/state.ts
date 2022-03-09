import { createState } from '@hookstate/core'
import { Persistence } from '@hookstate/persistence'

import { Authorize } from '@/schema'

export const authState = createState<Authorize | null>(null)
authState.attach(Persistence('auth'))
