import React, { ReactNode } from 'react'
import Link from 'next/link'
import Head from 'next/head'

type Props = {
    children?: ReactNode
    title?: string
    id?: number
}

const P5rbLayout = ({ children, title = 'sketch', id }: Props) => (
    <div>
        <Head>
            <title>{title}</title>
            <meta charSet="utf-8" />
            <meta name="viewport" content="initial-scale=1.0, width=device-width" />
            <link rel="icon" href="/favicon.ico" />
            <script async src="https://cdn.jsdelivr.net/npm/ruby-3_2-wasm-wasi@next/dist/browser.script.iife.js"></script>
            <script async src="https://cdn.jsdelivr.net/npm/p5@1.5.0/lib/p5.js"></script>
            <script async type="text/ruby" src="../../p5.rb"></script>
            <script async type="text/ruby" src={`../../programs/${id}.rb`}></script>
            <script type="text/ruby">P5::init</script>
        </Head>
        <header className="mx-4 mt-4">
            <nav>
                <Link href="/" className="text-customLink hover:text-customLinkHover">◀</Link>
                <span> | </span>
                <Link href="../[id]" as={`../${id}`} className="text-customLink hover:text-customLinkHover">switch image</Link>
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

export default P5rbLayout
