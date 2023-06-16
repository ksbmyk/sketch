import * as React from 'react'
import ListItem from './ListItem'
import { Image } from '../interfaces'

type Props = {
  items: Image[]
}

const List = ({ items }: Props) => (
    <div className="flex min-h-screen flex-col items-center justify-between p-24">
        <div className='grid-container'>
            {items.map((item) => (
              <div className='grid-item' key={item.id}>
                  <ListItem data={item} />
              </div>
          ))}
        </div>
    </div>
)

export default List
