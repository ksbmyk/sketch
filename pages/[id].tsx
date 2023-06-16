import { GetStaticProps, GetStaticPaths } from 'next'
import { useEffect, useState } from 'react';

import { Image } from '../interfaces'
import { imageData } from '../utils/image-data'
import DetailLayout from '../components/DetailLayout'
import ListDetail from '../components/ListDetail'

type Props = {
  item?: Image
  errors?: string
}

const StaticPropsDetail = ({ item, errors }: Props) => {
  const [fileContent, setFileContent] = useState('');

  useEffect(() => {
    // const filePath = new URL(`programs/${id}.rb`, router.asPath).toString();
    const filePath = `programs/${item.id}.rb`;
    fetch(filePath)
        .then((response) => response.text())
        .then((data) => setFileContent(data))
        .catch((error) => console.log(error));
  }, []);

  if (errors) {
    return (
      <DetailLayout title="Error | Next.js + TypeScript Example">
        <p>
          <span style={{ color: 'red' }}>Error:</span> {errors}
        </p>
      </DetailLayout>
    )
  }

  return (
    <DetailLayout
      title={`${item ? item.id : 'Image Data'}`}
      id={item.id}
    >
      {item && <ListDetail item={item} code={fileContent}/>}
    </DetailLayout>
  )
}

export default StaticPropsDetail

export const getStaticPaths: GetStaticPaths = async () => {
  // Get the paths we want to pre-render based on images
  const paths = imageData.map((image) => ({
    params: { id: image.id.toString() },
  }))

  // We'll pre-render only these paths at build time.
  // { fallback: false } means other routes should 404.
  return { paths, fallback: false }
}

// This function gets called at build time on server-side.
// It won't be called on client-side, so you can even do
// direct database queries.
export const getStaticProps: GetStaticProps = async ({ params }) => {
  try {
    const id = params?.id
    const item = imageData.find((data) => data.id === Number(id))
    // By returning { props: item }, the StaticPropsDetail component
    // will receive `item` as a prop at build time
    return { props: { item } }
  } catch (err: any) {
    return { props: { errors: err.message } }
  }
}
