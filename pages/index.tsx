import { GetStaticProps } from 'next'

import { Image } from '../interfaces'
import { imageData, PER_PAGE } from '../utils/image-data'
import Layout from '../components/Layout'
import List from '../components/List'
import Pagination from '../components/Pagination'

type Props = {
    items: Image[]
    totalPages: number
}
const WithStaticProps = ({ items, totalPages }: Props) => (
    <Layout title="sketch">
        <List items={items} />
        <Pagination currentPage={1} totalPages={totalPages} />
    </Layout>
)

export const getStaticProps: GetStaticProps = async () => {
    const items: Image[] = imageData.slice(0, PER_PAGE)
    const totalPages = Math.ceil(imageData.length / PER_PAGE)
    return { props: { items, totalPages } }
}

export default WithStaticProps
