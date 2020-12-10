import getSecondLang from '@utils/getSecondLang';
import req from './request';

interface User {
  id: number;
  avatar: string;
  nickname: string;
  lang: string;
}

interface Message {
  text: string;
  source: string;
  user: User;
}

export default async (message: Message, lang: string, users: User[]): Promise<string> => {
  const authorLang = message.user.lang;
  const { text, source } = message;

  if (authorLang !== lang) {
    if (message.source === lang) {
      const translatedText = await req(text, source, authorLang); // 원본: 내가 사용하는 언어, 번역본: 메시지 작성자의 언어
      const texts = {
        originText: text,
        translatedText,
      };
      return JSON.stringify(texts);
    } else {
      const translatedText = await req(text, source, lang); // 원본: 내가 사용하는 언어, 번역본: 메시지 작성자의 언어
      const texts = {
        originText: text,
        translatedText,
      };
      return JSON.stringify(texts);
    }
  }
  const secondLang = getSecondLang(users, lang);
  const translatedText = await req(text, source, secondLang);
  const texts = {
    originText: text,
    translatedText,
  };
  return JSON.stringify(texts);
};
