import { NextApiRequest, NextApiResponse } from 'next'
import { imageData } from '../../../utils/image-data'

const handler = (_req: NextApiRequest, res: NextApiResponse) => {
  try {
    if (!Array.isArray(imageData)) {
      throw new Error('Cannot find user data')
    }

    res.status(200).json(imageData)
  } catch (err: any) {
    res.status(500).json({ statusCode: 500, message: err.message })
  }
}

export default handler
