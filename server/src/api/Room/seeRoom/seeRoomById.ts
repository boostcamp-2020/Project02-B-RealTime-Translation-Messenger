import { PrismaClient, Room } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    seeRoomById: (_: Room, { id }: { id: number }) =>
      prisma.room.findOne({
        where: {
          id,
        },
      }),
  },
};
