import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    allRooms: (_: any, __: any, { request, isAuthenticated }: any) => {
      isAuthenticated(request);
      return prisma.room.findMany({
        include: {
          users: true,
          messages: true,
        },
      });
    },
  },
};
