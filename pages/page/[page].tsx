import { GetStaticPaths, GetStaticProps } from 'next'

import { Image } from '../../interfaces'
import { imageData, PER_PAGE } from '../../utils/image-data'
import Layout from '../../components/Layout'
import List from '../../components/List'
import Pagination from '../../components/Pagination'

type Props = {
    items: Image[]
    currentPage: number
    totalPages: number
}

const PaginatedPage = ({ items, currentPage, totalPages }: Props) => (
    <Layout title={`sketch - page ${currentPage}`}>
        <List items={items} />
        <Pagination currentPage={currentPage} totalPages={totalPages} />
    </Layout>
)

export const getStaticPaths: GetStaticPaths = async () => {
    const totalPages = Math.ceil(imageData.length / PER_PAGE)
    const paths = Array.from({ length: totalPages - 1 }, (_, i) => ({
        params: { page: String(i + 2) },
    }))
    return { paths, fallback: false }
}

export const getStaticProps: GetStaticProps = async ({ params }) => {
    const currentPage = Number(params?.page)
    const totalPages = Math.ceil(imageData.length / PER_PAGE)
    const start = (currentPage - 1) * PER_PAGE
    const items: Image[] = imageData.slice(start, start + PER_PAGE)
    return { props: { items, currentPage, totalPages } }
}

export default PaginatedPage
