import generateToken from '@utils/generateToken';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

interface EnterInfo {
  nickname: string;
  avatar: string;
  lang: string;
  code: string;
  token: string;
}

export default {
  Mutation: {
    enterRoom: async (
      _: any,
      { nickname, avatar, lang, code }: EnterInfo,
    ): Promise<{ userId: number; roomId: number; token: string }> => {
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
      const jwtToken = generateToken(result.id, nickname, avatar, lang, result.rooms[0].id);
      return { userId: result.id, roomId: result.rooms[0].id, token: jwtToken };
    },
  },
};
