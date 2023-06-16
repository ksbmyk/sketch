import * as React from 'react'
import ListItem from './ListItem'
import { Image } from '../interfaces'

type Props = {
  items: Image[]
}

const List = ({ items }: Props) => (
  <ul>
    {items.map((item) => (
      <li key={item.id}>
        <ListItem data={item} />
      </li>
    ))}
  </ul>
)

export default List
