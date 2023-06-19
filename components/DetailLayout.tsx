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
      <meta name='description' content='sketch stock with creative coding by chobishiba' key='desc' />
      <meta name='twitter:card' content='summary' />
      <meta property='og:title' content='top' />
      <meta property='og:site_name' content='Sketch' />
      <meta property='og:description' content={`${id} sketch by chobishiba`} />
      <meta property='og:url' content={`https://ksbmyk.github.io/sketch/${id}`} />
      <meta property='og:image' content={`https://ksbmyk.github.io/sketch/images/${id}.png`} />
      <meta property='og:type' content='website' />
      <link rel="icon" href="../favicon.ico" />
    </Head>
    <header className="mx-4 mt-4">
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
    <footer className="mx-4 mb-4">
      <nav>
        <Link href="/" className="text-customLink hover:text-customLinkHover">◀</Link>
      </nav>
    </footer>
  </div>
)

export default DetailLayout
