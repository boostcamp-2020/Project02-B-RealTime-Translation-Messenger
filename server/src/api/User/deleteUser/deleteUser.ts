import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Mutation: {
    deleteUser: async (_: any, __: any, { request, isAuthenticated }: any): Promise<boolean> => {
      isAuthenticated(request);
      await prisma.$queryRaw`DELETE FROM User WHERE id = ${request.user.id}`;
      const restUser = await prisma.$queryRaw`SELECT COUNT(*) FROM _RoomToUser WHERE A = ${request.user.roomId} `;
      if (!restUser[0]['COUNT(*)']) {
        await prisma.$queryRaw`DELETE FROM Room WHERE id = ${request.user.roomId}`;
      }
      return true;
    },
  },
};
