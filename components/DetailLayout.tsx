import React, { ReactNode } from 'react'
import Link from 'next/link'
import Head from 'next/head'
import { isMobile } from "react-device-detect"

type Props = {
  children?: ReactNode
  title?: string
  id?: number
}

const DetailLayout = ({ children, title = 'sketch', id }: Props) => (
  <div>
    <Head>
      <title>{title}</title>
      <meta charSet="utf-8" />
      <meta name="viewport" content="initial-scale=1.0, width=device-width" />
      <link rel="icon" href="favicon.ico" />
    </Head>
    <header className="mx-4">
      <nav>
        <Link href="/" className="text-customLink hover:text-customLinkHover">◀</Link>
          {!isMobile &&
            <>
              <span> | </span>
              <Link href="../p5rb/[id]" as={`../p5rb/${id}`} className="text-customLink hover:text-customLinkHover">switch p5.rb</Link>
            </>
          }
      </nav>
    </header>
    {children}
    <footer className="mx-4">
      <nav>
        <Link href="/" className="text-customLink hover:text-customLinkHover">◀</Link>
      </nav>
    </footer>
  </div>
)

export default DetailLayout
