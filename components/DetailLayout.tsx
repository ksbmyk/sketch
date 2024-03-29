import React, { ReactNode } from 'react'
import Link from 'next/link'
import Head from 'next/head'
import { isMobile } from "react-device-detect"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCaretLeft, faSync } from "@fortawesome/free-solid-svg-icons";

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
      <meta property='og:title' content='chobishiba sketch' />
      <meta property='og:site_name' content='chobishiba sketch' />
      <meta property='og:description' content={`${id} sketch by chobishiba`} />
      <meta property='og:url' content={`https://ksbmyk.github.io/sketch/${id}`} />
      <meta property='og:image' content={`https://ksbmyk.github.io/sketch/images/${id}.png`} />
      <meta property='og:type' content='website' />
      <link rel="icon" href="../favicon.ico" />
    </Head>
    <header className="mx-4 mt-4">
      <nav className="flex items-center">
        <Link href="/" className="text-customLink hover:text-customLinkHover flex items-center">
          <FontAwesomeIcon icon={faCaretLeft} className="h-[20px]" />
        </Link>
          {!isMobile &&
            <>
              <span className="ml-1">|</span>
              <Link href="../p5rb/[id]" as={`../p5rb/${id}`} className="text-customLink hover:text-customLinkHover flex items-center ml-1">
                <FontAwesomeIcon icon={faSync} className="h-[20px]" /><span className="ml-2">p5.rb</span>
              </Link>
            </>
          }
      </nav>
    </header>
    {children}
    <footer className="mx-4 mb-4">
      <nav>
        <Link href="/" className="text-customLink hover:text-customLinkHover flex items-center">
          <FontAwesomeIcon icon={faCaretLeft} className="h-[20px]" />
        </Link>
      </nav>
    </footer>
  </div>
)

export default DetailLayout
