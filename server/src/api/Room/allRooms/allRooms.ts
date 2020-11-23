import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    allRooms: () =>
      prisma.room.findMany({
        include: {
          users: true,
        },
      }),
  },
};
