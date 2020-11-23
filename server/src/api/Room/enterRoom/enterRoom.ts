import { PrismaClient } from '@prisma/client';
import errorMessage from '@utils/errorMessage';

const prisma = new PrismaClient();

interface User {
  nickname: string;
  avatar: string;
  lang: string;
  code: string;
}

export default {
  Mutation: {
    enterRoom: async (_: any, { nickname, avatar, lang, code }: User): Promise<boolean> => {
      try {
        await prisma.user.create({
          data: {
            nickname,
            lang,
            avatar,
            rooms: {
              connect: { code },
            },
          },
          include: { rooms: true },
        });

        return true;
      } catch (error) {
        throw new Error(errorMessage.already);
      }
    },
  },
};
