import * as React from 'react'
import { Image } from '../interfaces'

type ListDetailProps = {
  item: Image,
  code: string
}

const ListDetail = ({ item: image, code: code }: ListDetailProps) => (
  <div>
    <p>ID: {image.id}</p>
      <textarea value={code} readOnly />
      <main></main>
  </div>
)

export default ListDetail
