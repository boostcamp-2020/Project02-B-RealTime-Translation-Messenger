import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

interface EnterInfo {
  nickname: string;
  avatar: string;
  lang: string;
  code: string;
}

export default {
  Mutation: {
    enterRoom: async (
      _: any,
      { nickname, avatar, lang, code }: EnterInfo,
    ): Promise<{ userId: number; roomId: number }> => {
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

      return { userId: result.id, roomId: result.rooms[0].id };
    },
  },
};
