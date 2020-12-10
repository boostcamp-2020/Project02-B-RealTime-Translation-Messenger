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

// TODO: Need Refactoring! :(
export default async (message: Message, me: User, users: User[]): Promise<string> => {
  const authorLang = message.user.lang;
  const { text, source } = message;
  const { id, lang: myLang } = me;

  if (authorLang !== myLang) {
    if (message.source === myLang) {
      const translatedText = await req(text, source, authorLang);
      const texts = {
        originText: text,
        translatedText,
      };
      return JSON.stringify(texts);
    }
    const translatedText = await req(text, source, myLang);
    const texts = {
      originText: text,
      translatedText,
    };
    return JSON.stringify(texts);
  } else {
    if (message.user.id === id) {
      if (message.source === myLang) {
        const secondLang = getSecondLang(users, myLang);
        const translatedText = await req(text, source, secondLang);
        const texts = {
          originText: text,
          translatedText,
        };
        return JSON.stringify(texts);
      }
      const translatedText = await req(text, source, myLang);
      const texts = {
        originText: text,
        translatedText,
      };
      return JSON.stringify(texts);
    } else {
      if (message.source === myLang) {
        const secondLang = getSecondLang(users, myLang);
        const translatedText = await req(text, source, secondLang);
        const texts = {
          originText: text,
          translatedText,
        };
        return JSON.stringify(texts);
      } else {
        const translatedText = await req(text, source, myLang);
        const texts = {
          originText: text,
          translatedText,
        };
        return JSON.stringify(texts);
      }
    }
  }
};
