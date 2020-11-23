import { PrismaClient } from '@prisma/client';
import errorMessage from '@utils/errorMessage';

const prisma = new PrismaClient();

interface EnterInfo {
  nickname: string;
  avatar: string;
  lang: string;
  code: string;
}

export default {
  Mutation: {
    enterRoom: async (_: any, { nickname, avatar, lang, code }: EnterInfo): Promise<number> => {
      const result = await prisma.user.create({
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

      return result.rooms[0].id;
    },
  },
};
