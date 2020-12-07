import { PrismaClient, Room } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    roomById: (_: Room, { id }: { id: number }, { request, isAuthenticated }: any) => {
      isAuthenticated(request);
      return prisma.room.findOne({
        where: {
          id,
        },
        include: {
          users: true,
          messages: true,
        },
      });
    },
  },
};
