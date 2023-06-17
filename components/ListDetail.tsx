import * as React from 'react'
import { Image } from '../interfaces'

type ListDetailProps = {
  item: Image,
  code: string
}

const ListDetail = ({ item: image, code: code }: ListDetailProps) => (
  <div className="grid grid-cols-1 sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-4">
    <div className="m-4 mr-8">
      <textarea className="bg-gray-200 p-3 text-sm h-textarea w-full resize-none" value={code} readOnly />
    </div>
    <div className="m-4">
      <main></main>
    </div>
  </div>
)

export default ListDetail
