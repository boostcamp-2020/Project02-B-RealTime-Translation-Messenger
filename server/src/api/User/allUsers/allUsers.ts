import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    allUsers: (_: any, __: any, { request, isAuthenticated }: any) => {
      isAuthenticated(request);
      return prisma.user.findMany({
        include: {
          rooms: true,
          messages: true,
        },
      });
    },
  },
};
