import { GetStaticProps } from 'next'
import Link from 'next/link'

import { Image } from '../interfaces'
import { imageData } from '../utils/image-data'
import Layout from '../components/Layout'
import List from '../components/List'

type Props = {
    items: Image[]
}
const WithStaticProps = ({ items }: Props) => (
    <Layout title="Users List | Next.js + TypeScript Example">
        <h1>Image List</h1>
        <p>
            Example fetching data from inside <code>getStaticProps()</code>.
        </p>
        <p>You are currently</p>
        <List items={items} />
        <p>
            <Link href="/">Go home</Link>
        </p>
    </Layout>
)

export const getStaticProps: GetStaticProps = async () => {
    // Example for including static props in a Next.js function component page.
    // Don't forget to include the respective types for any props passed into
    // the component.
    const items: Image[] = imageData
    return { props: { items } }
}

export default WithStaticProps