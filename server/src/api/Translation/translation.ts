import { Context } from '@interfaces/context';
import { PrismaClient } from '@prisma/client';
import getSecondLang from '@utils/getSecondLang';
import req from '@utils/request';
import dect from '@utils/dect';

interface TranslationForm {
  text: string;
  target: string;
}

interface translationResponse {
  translatedText: string;
}

const prisma = new PrismaClient();

export default {
  Mutation: {
    translation: async (
      _: translationResponse,
      args: TranslationForm,
      { request, isAuthenticated }: Context,
    ): Promise<translationResponse> => {
      try {
        isAuthenticated(request);
        const { text } = args;
        const source = await dect(text);
        const { roomId, lang } = request.user;
        const users = await prisma.room
          .findOne({
            where: {
              id: roomId,
            },
          })
          .users();

        if (lang === source) {
          const target = getSecondLang(
            users.filter((user) => !user.isDeleted),
            source,
          );
          const translatedText = await req(text, source, target);
          return { translatedText: translatedText };
        }
        const translatedText = await req(text, source, lang);
        if (translatedText) {
          return { translatedText: translatedText };
        } else {
          return { translatedText: translatedText };
        }
      } catch (e) {
        return { translatedText: '' };
      }
    },
  },
};
