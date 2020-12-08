import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    me: async (_: any, __: any, { request, isAuthenticated }: any) => {
      isAuthenticated(request);
      const { id } = request.user;
      return prisma.user.findOne({
        where: {
          id,
        },
      });
    },
  },
};
