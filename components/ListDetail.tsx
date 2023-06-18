import * as React from 'react'
import { Image } from '../interfaces'

type ListDetailProps = {
  item: Image,
  code: string
}

const ListDetail = ({ item: image, code: code }: ListDetailProps) => (
    <div className="grid grid-cols-3 sm:grid-cols-1 md:grid-cols-1 lg:grid-cols-3 gap-4">
        <div className="m-4 col-span-1">
            <textarea className="bg-gray-200 p-3 text-sm h-textarea w-full resize-none" value={code} readOnly />
        </div>
        <div className="m-4 col-span-2">
            <img src={`../images/${image.name}`} alt={image.name}  width={700} height={700} />
        </div>
    </div>
)

export default ListDetail
