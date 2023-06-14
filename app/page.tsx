import Image from 'next/image'
import Link from 'next/link'

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
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
        <div className='grid-container'>
          {images.map((image, index) => (
              <div className='grid-item' key={index}>
                <Link href={`/${image.substring(0, 8)}`}>
                  <Image src={`/images/${image}`} alt="" width={250} height={250} />
                </Link>
              </div>
          ))}
        </div>
    </main>
  )
}
