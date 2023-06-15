/** @type {import('next').NextConfig} */
const fs = require('fs');
const path = require('path');

const nextConfig = {
    output: 'export',
    assetPrefix: process.env.BASE_PATH || '',
    basePath: process.env.BASE_PATH || '',
    trailingSlash: false,
    generateStaticParams: async function () {
        const paths = {
            '/': { page: '/' }, // ルートページ
        };

        // programsディレクトリ内のファイルを取得
        // const directoryPath = path.join(__dirname, 'programs');
        // const files = fs.readdirSync(directoryPath);

        // ファイル名からidを抽出してidsに追加
        // const ids = files.map((file) => {
        //     const { name } = path.parse(file);
        //     return name;
        // });

        const ids = ['20230614', '20230613'];

        // 各idに対応するページを追加
        ids.forEach((id) => {
            paths[`/${id}`] = { page: '/[id]', query: { id } };
        });
        return paths;
    },

}

module.exports = nextConfig
