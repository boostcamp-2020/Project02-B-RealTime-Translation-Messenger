import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Mutation: {
    deleteUser: async (
      _: any,
      { userId, roomId }: { userId: number; roomId: number },
    ): Promise<boolean> => {
      await prisma.$queryRaw`DELETE FROM User WHERE id = ${userId}`;
      const restUser = await prisma.$queryRaw`SELECT COUNT(*) FROM _RoomToUser WHERE A = ${roomId} `;
      if (!restUser[0]['COUNT(*)']) {
        await prisma.$queryRaw`DELETE FROM Room WHERE id = ${roomId}`;
      }
      return true;
    },
  },
};
