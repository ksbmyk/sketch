/** @type {import('next').NextConfig} */
const nextConfig = {
    output: 'export',
    assetPrefix: process.env.BASE_PATH || '',
    basePath: process.env.BASE_PATH || '',
    trailingSlash: true,
}

module.exports = nextConfig
