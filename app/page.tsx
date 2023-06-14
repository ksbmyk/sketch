import Image from 'next/image'

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="flex">
        <Image
          className="w-1/3 mr-4"
          src="/images/20230506.png"
          alt=""
          width={250}
          height={37}
        />
        <Image
            className="w-1/3 mr-4"
            src="/images/20230506.png"
            alt=""
            width={250}
            height={37}
        />
        <Image
            className="w-1/3"
            src="/images/20230506.png"
            alt=""
            width={250}
            height={37}
        />
      </div>
    </main>
  )
}
