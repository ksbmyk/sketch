import React from 'react'
import Link from 'next/link'

import { Image } from '../interfaces'

type Props = {
  data: Image
}

const ListItem = ({ data }: Props) => (
  <Link href="/users/[id]" as={`/user/${data.id}`}>
    {data.id}:{data.name}
  </Link>
)

export default ListItem
