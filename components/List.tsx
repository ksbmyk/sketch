import * as React from 'react'
import ListItem from './ListItem'
import { Image } from '../interfaces'

type Props = {
  items: Image[]
}

const List = ({ items }: Props) => (
    <div className="m-8 flex justify-center">
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-3 gap-4">
            {items.map((item) => (
              <div className='w-full sm:w-auto' key={item.id}>
                  <ListItem data={item} />
              </div>
          ))}
        </div>
    </div>
)

export default List
