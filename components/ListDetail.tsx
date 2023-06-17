import * as React from 'react'
import { Image } from '../interfaces'

type ListDetailProps = {
  item: Image,
  code: string
}

const ListDetail = ({ item: image, code: code }: ListDetailProps) => (
  <div className="detail-grid-container">
    <div className="detail-grid-item">
      <textarea className="bg-gray-200 p-3 text-sm h-full w-full" value={code} readOnly />
    </div>
    <div className="detail-grid-item">
      <main></main>
    </div>
  </div>
)

export default ListDetail
