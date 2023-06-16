import * as React from 'react'

import { Image } from '../interfaces'

type ListDetailProps = {
  item: Image
}

const ListDetail = ({ item: image }: ListDetailProps) => (
  <div>
    <h1>Detail for {image.name}</h1>
    <p>ID: {image.id}</p>
      <main></main>
  </div>
)

export default ListDetail
