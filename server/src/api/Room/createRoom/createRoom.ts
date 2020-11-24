import { PrismaClient } from '@prisma/client';
import { getRandomNumber, randomImage } from '@utils/util';

const prisma = new PrismaClient();

interface User {
  nickname: string;
  avatar: string;
  lang: string;
}

export default {
  Mutation: {
    createRoom: async (_: any, args: User): Promise<{ id: number; code: string }> => {
      const { nickname, avatar, lang } = args;
      const user = await prisma.user.create({
        data: {
          nickname,
          lang,
          avatar,
        },
      });
      const randomCode = getRandomNumber(6);
      const newRoom = await prisma.room.create({
        data: {
          users: {
            connect: {
              id: user.id,
            },
          },
          avatar: randomImage(),
          code: randomCode,
        },
      });
      return { id: newRoom.id, code: randomCode };
    },
  },
};
