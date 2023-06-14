import { useRouter } from 'next/router';
import { useEffect, useState } from 'react';
import Link from 'next/link'
import './id.css'

const DynamicPage = () => {
    const router = useRouter();
    const { id } = router.query;
    const { query, isReady } = useRouter()
    const [fileContent, setFileContent] = useState('');

    useEffect(() => {
        if (!isReady) return;
        const filePath = `programs/${id}.rb`
        fetch(filePath)
            .then((response) => response.text())
            .then((data) => setFileContent(data))
            .catch((error) => console.log(error));
    }, [isReady, id]);

    return (
        <div>
            <div className="grid-container">
                <div className="grid-item">
                    <textarea className="bg-gray-200 p-3 text-sm h-full w-full" value={fileContent} readOnly />
                </div>
                <div className="grid-item">
                    {id && (
                     <img src={`images/${id}.png`} className="" />
                    )}
                </div>
            </div>
            <div className="grid-container">
                <div className="grid-item">
                    <Link href={`/`}>◀</Link>
                </div>
            </div>
        </div>
    );
};

export default DynamicPage;