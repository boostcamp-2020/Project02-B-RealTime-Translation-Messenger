import { PrismaClient } from '@prisma/client';
import { getRandomNumber, randomImage } from '@utils/util';
import generateToken from '@utils/generateToken';

const prisma = new PrismaClient();

interface User {
  nickname: string;
  avatar: string;
  lang: string;
}

export default {
  Mutation: {
    createRoom: async (
      _: any,
      args: User,
    ): Promise<{ userId: number; roomId: number; code: string; token: string }> => {
      const { nickname, avatar, lang } = args;
      const newUser = await prisma.user.create({
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
              id: newUser.id,
            },
          },
          avatar: randomImage(),
          code: randomCode,
        },
      });
      const jwtToken = generateToken(newUser, newRoom.id);
      return { userId: newUser.id, roomId: newRoom.id, code: randomCode, token: jwtToken };
    },
  },
};
