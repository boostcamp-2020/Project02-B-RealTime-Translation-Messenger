import axios from 'axios';

export default async (query: string): Promise<string> => {
  const data = {
    query,
  };
  const config = {
    headers: {
      'X-NCP-APIGW-API-KEY-ID': process.env.CLIENT_ID,
      'X-NCP-APIGW-API-KEY': process.env.CLIENT_SECRET,
      'Content-Type': 'application/json',
    },
  };
  const res = await axios.post(process.env.PAPAGO_DECT_URL as string, data, config);
  return res.data.langCode;
};
