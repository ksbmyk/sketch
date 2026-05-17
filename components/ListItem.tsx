import React from 'react'
import Link from 'next/link'
import { useRouter } from 'next/router'
import { Image } from '../interfaces'

type Props = {
  data: Image
}

const ListItem = ({ data }: Props) => {
  const { basePath } = useRouter()
  return (
    <Link href="/[id]" as={`/${data.id}`}>
      <img src={`${basePath}/images/${data.name}`} alt={data.name} width={250} height={250} loading="lazy" />
    </Link>
  )
}

export default ListItem
