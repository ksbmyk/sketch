import * as React from 'react'
import { Image } from '../interfaces'
import { MobileView, BrowserView } from "react-device-detect"

type ListDetailProps = {
  item: Image,
  code: string
}

const ListDetail = ({ item: image, code: code }: ListDetailProps) => {
    return(
        <>
            <MobileView>
                <div className="grid grid-cols-1 gap-4">
                    <div className="m-4">
                        <img src={`../images/${image.name}`} alt={image.name} width={700} height={700}/>
                    </div>
                    <div className="m-4">
                        <textarea className="bg-gray-200 p-3 text-sm h-textarea w-full resize-none" value={code} readOnly/>
                    </div>
                </div>
            </MobileView>
            <BrowserView>
                <div className="grid grid-cols-3 sm:grid-cols-1 md:grid-cols-1 lg:grid-cols-3 gap-4">
                    <div className="m-4 col-span-1">
                        <textarea className="bg-gray-200 p-3 text-sm h-textarea w-full resize-none" value={code} readOnly/>
                    </div>
                    <div className="m-4 col-span-2">
                        <img src={`../images/${image.name}`} alt={image.name} width={700} height={700}/>
                    </div>
                </div>
            </BrowserView>
        </>
    )
}

export default ListDetail
