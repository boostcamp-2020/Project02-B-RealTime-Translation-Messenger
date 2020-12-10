import { PrismaClient } from '@prisma/client';
import getSecondLang from '@utils/getSecondLang';
import req from '@utils/request';
import dect from '@utils/dect';

interface TranslationForm {
  text: string;
  target: string;
}

const prisma = new PrismaClient();

export default {
  Mutation: {
    translation: async (
      _: any,
      args: TranslationForm,
      { request, isAuthenticated }: any,
    ): Promise<{ translatedText: string }> => {
      try {
        isAuthenticated(request);
        const { text } = args;
        const source = await dect(text);
        const { roomId } = request.user;
        const users = await prisma.room
          .findOne({
            where: {
              id: roomId,
            },
          })
          .users();

        const target = getSecondLang(users, source);
        const translatedText = await req(text, source, target);
        return { translatedText: translatedText };
      } catch (e) {
        return { translatedText: '텍스트를 입력하세요' };
      }
    },
  },
};
