import { PrismaClient } from '@prisma/client';
import getRandomNumber from '../../../utils/util';
const prisma = new PrismaClient();

export default {
  Mutation: {
    createUser: async (_: any, args: any) => {
      const { nickname, avatar, lang } = args;
      try {
        const user = await prisma.user.create({
          data: {
            nickname,
            lang,
            avatar,
          },
        });
        const randomCode = getRandomNumber(6);
        await prisma.room.create({
          data: {
            users: {
              connect: {
                id: user.id,
              },
            },
            avatar: 'https://picsum.photos/200',
            code: randomCode,
          },
        });
        return randomCode;
      } catch (error) {
        throw new Error('error');
      }
    },
  },
};
