/** @type {import('next').NextConfig} */
const nextConfig = {
    basePath: process.env.GITHUB_ACTIONS && "/sketch",
    trailingSlash: false,
}

module.exports = nextConfig
