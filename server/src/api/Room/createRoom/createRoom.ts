import { PrismaClient } from '@prisma/client';
import { getRandomNumber, randomImage } from '@utils/util';
import generateToken from '@utils/generateToken';
import ERROR_MSG from '@utils/errorMessage';

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
      if (!nickname || !avatar || !lang) throw new Error(ERROR_MSG.invalid);
      const newUser = await prisma.user.create({
        data: {
          nickname,
          lang,
          avatar,
        },
      });

      let randomCode;
      while (true) {
        randomCode = getRandomNumber(6);
        const isExistRoom = await prisma.room.findOne({ where: { code: randomCode } });
        if (!isExistRoom) break;
      }

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
