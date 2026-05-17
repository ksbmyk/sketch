import * as React from 'react'
import Link from 'next/link'

type Props = {
  currentPage: number
  totalPages: number
}

const pageHref = (page: number) => (page === 1 ? '/' : `/page/${page}`)

const Pagination = ({ currentPage, totalPages }: Props) => {
  if (totalPages <= 1) return null

  const pages = Array.from({ length: totalPages }, (_, i) => i + 1)
  const hasPrev = currentPage > 1
  const hasNext = currentPage < totalPages

  const baseLink =
    'px-3 py-1 rounded border text-customLink hover:text-customLinkHover'
  const disabledLink =
    'px-3 py-1 rounded border text-gray-300 cursor-not-allowed'

  return (
    <nav className="my-8 flex justify-center items-center gap-2 text-sm">
      {hasPrev ? (
        <Link href={pageHref(currentPage - 1)} className={baseLink}>
          ←
        </Link>
      ) : (
        <span className={disabledLink}>←</span>
      )}

      {pages.map((page) =>
        page === currentPage ? (
          <span
            key={page}
            className="px-3 py-1 rounded border bg-customLink text-white"
          >
            {page}
          </span>
        ) : (
          <Link key={page} href={pageHref(page)} className={baseLink}>
            {page}
          </Link>
        )
      )}

      {hasNext ? (
        <Link href={pageHref(currentPage + 1)} className={baseLink}>
          →
        </Link>
      ) : (
        <span className={disabledLink}>→</span>
      )}
    </nav>
  )
}

export default Pagination
