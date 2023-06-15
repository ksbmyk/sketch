/** @type {import('next').NextConfig} */
const nextConfig = {
    output: 'export',
    basePath: process.env.GITHUB_ACTIONS && "/sketch",
    trailingSlash: true,
}

module.exports = nextConfig
