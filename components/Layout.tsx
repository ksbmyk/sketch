import React, { ReactNode } from 'react'
import Link from 'next/link'
import Head from 'next/head'

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
    </Head>
    <header>
      <nav>
        <Link href="/">Home</Link> |{' '}
        <Link href="/users">Users List</Link> |{' '}
        <a href="/api/images">Users API</a>
      </nav>
    </header>
    {children}
    <footer>
      <hr />
      <span>
          <Link href="https://twitter.com/chobishiba" target="_blank">
                    <img src="/twitter_logo_black.svg" alt="@chobishiba" width={20} height={20}/>
          </Link>
      </span>
    </footer>
  </div>
)

export default Layout
