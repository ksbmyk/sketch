import React, { ReactNode } from 'react'
import Link from 'next/link'
import Head from 'next/head'
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faTwitter, faGithub } from "@fortawesome/free-brands-svg-icons"

type Props = {
  children?: ReactNode
  title?: string
}

const Layout = ({ children, title = 'sketch' }: Props) => (
  <div>
    <Head>
      <title>{title}</title>
      <meta charSet="utf-8" />
      <meta name="viewport" content="initial-scale=1.0, width=device-width" />
      <meta name='description' content='sketch stock with creative coding by chobishiba' key='desc' />
      <meta name='twitter:card' content='summary' />
      <meta property='og:title' content='chobishiba sketch' />
      <meta property='og:site_name' content='chobishiba sketch' />
      <meta property='og:description' content='sketch stock with creative coding by chobishiba' />
      <meta property='og:url' content='https://ksbmyk.github.io/sketch' />
      <meta property='og:image' content='https://ksbmyk.github.io/sketch/images/20230614.png' />
      <meta property='og:type' content='website' />
      <link rel="icon" href="favicon.ico" />
    </Head>

    {children}
    <footer className="flex justify-center mb-4">
      <Link href="https://twitter.com/chobishiba" target="_blank" className="text-customLink hover:text-customLinkHover">
        <span> <FontAwesomeIcon icon={faTwitter} className="h-[20px]" /> </span>
      </Link>
      <span className="ml-2"></span>
      <Link href="https://github.com/ksbmyk/sketch" target="_blank" className="text-customLink hover:text-customLinkHover">
        <span> <FontAwesomeIcon icon={faGithub} className="h-[20px]" /> </span>
      </Link>
    </footer>
  </div>
)

export default Layout
