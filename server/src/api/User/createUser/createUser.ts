import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Mutation: {
    createUser: async (_: any, args: any) => {
      const { nickname, avatar, password = '', lang } = args;
      const user = await prisma.user.create({
        data: {
          nickname,
          avatar,
          lang,
          password,
        },
      });
      if (user) return true;
      return false;
    },
  },
};
