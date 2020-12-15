import { Context } from '@interfaces/context';
import { PrismaClient, Room } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    allRooms: (_: Room[], __: null, { request, isAuthenticated }: Context): Promise<Room[]> => {
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
