import { useRouter } from 'next/router';
import { useEffect, useState } from 'react';
import Link from 'next/link'
import Head from 'next/head';
import './id.css'

const DynamicPage = () => {
    const router = useRouter();
    const { id } = router.query;
    const { query, isReady } = useRouter()
    const [fileContent, setFileContent] = useState('');

    useEffect(() => {
        if (!isReady) return;
        const filePath = `programs/${id}.rb`;
        fetch(filePath)
            .then((response) => response.text())
            .then((data) => setFileContent(data))
            .catch((error) => console.log(error));
    }, [isReady, id]);

    return (
        <div>
            <Head>
                <script src="https://cdn.jsdelivr.net/npm/ruby-3_2-wasm-wasi@next/dist/browser.script.iife.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/p5@1.5.0/lib/p5.js"></script>
                <script type="text/ruby" src="p5.rb"></script>
                <script type="text/ruby" src="programs/20230614.rb"></script>
                <script type="text/ruby">P5::init</script>
            </Head>
            <div className="grid-container">
                <div className="grid-item">
                    <textarea className="bg-gray-200 p-3 text-sm h-full w-full" value={fileContent} readOnly />
                </div>
                <div className="grid-item">
                    <main></main>
                </div>
            </div>
            <div className="grid-container">
                <div className="grid-item">
                    <Link href={`/`}>◀</Link>
                </div>

                <div className="grid-item">
                    <button id="reloadButton">Reload</button>
                </div>
            </div>
        </div>
    );
};

export default DynamicPage;