import getSecondLang from '@utils/getSecondLang';
import { Message, User } from '@prisma/client';
import { UserToken } from '@interfaces/request';
import req from './request';

export default async (
  message: Message & {
    user: User;
  },
  me: UserToken,
  users: User[],
): Promise<string> => {
  const { lang: authorLang } = message.user;
  const { text, source } = message;
  const { lang: myLang } = me;

  if (authorLang !== myLang) {
    if (source === myLang) {
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
  }
  if (message.source === myLang) {
    const secondLang = getSecondLang(
      users.filter((user) => !user.isDeleted),
      myLang,
    );
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
};
