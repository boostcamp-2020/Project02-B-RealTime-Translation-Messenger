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
  try {
    const res = await axios.post(process.env.PAPAGO_TRANSLTE_URL as string, data, config);
    return res.data.message.result.translatedText;
  } catch (err) {
    return '';
  }
};
