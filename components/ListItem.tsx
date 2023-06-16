import React from 'react'
import Link from 'next/link'

import { Image } from '../interfaces'

type Props = {
  data: Image
}

const ListItem = ({ data }: Props) => (

  <Link href="/[id]" as={`/${data.id}`}>
    <img src={`/images/${data.name}`} alt={data.name} width={250} height={250} />
  </Link>
)

export default ListItem
