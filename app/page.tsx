import Image from 'next/image'
import Link from 'next/link'
import Head from 'next/head';

const images = [
  '20230614.png',
  '20230613.gif',
  '20230612.png',
  '20230514.png',
  '20230513.gif',
  '20230508.png',
  '20230506.png',
  '20230505.png',
  '20230312.png',
];

export default function Home() {
  return (
      <>
        <Head>
          <meta name='description' content='sketch stock with creative coding' key='desc' />
          <meta name='twitter:card' content='summary_large_image' />
          <meta property='og:title' content='top' />
          <meta property='og:site_name' content='Sketch' />
          <meta property='og:description' content='sketch stock with creative coding' />
          <meta property='og:url' content='https://ksbmyk.github.io/sketch' />
          <meta property='og:image' content='https://ksbmyk.github.io/sketch/images/20230614.png' />
          <meta property='og:type' content='website' />
        </Head>
        <main className="flex min-h-screen flex-col items-center justify-between p-24">
            <div className='grid-container'>
              {images.map((image, index) => (
                  <div className='grid-item' key={index}>
                    <Link href={`/${image.substring(0, 8)}`}>
                      <Image src={`/sketch/images/${image}`} alt="" width={250} height={250} />
                    </Link>
                  </div>
              ))}
            </div>
            <div>
                <Link href="https://twitter.com/chobishiba" target="_blank">
                    <Image src="/twitter_logo_black.svg" alt="@chobishiba" width={20} height={20}/>
                </Link>
            </div>
        </main>
      </>
  )
}
