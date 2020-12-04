import axios from 'axios';

export default async (text: string, source: string, target: string): Promise<string> => {
  if (source === target) return text;
  const data = {
    source,
    target,
    text,
  };
  const config = {
    headers: {
      'X-NCP-APIGW-API-KEY-ID': process.env.CLIENT_ID,
      'X-NCP-APIGW-API-KEY': process.env.CLIENT_SECRET,
      'Content-Type': 'application/json',
    },
  };
  const res = await axios.post(
    'https://naveropenapi.apigw.ntruss.com/nmt/v1/translation',
    data,
    config,
  );
  return res.data.message.result.translatedText;
};
