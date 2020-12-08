import { PrismaClient } from '@prisma/client';
import { withFilter } from 'graphql-subscriptions';

const prisma = new PrismaClient();

export default {
  Mutation: {
    deleteUser: async (
      _: any,
      __: any,
      { pubsub, request, isAuthenticated }: any,
    ): Promise<boolean> => {
      isAuthenticated(request);
      const { id: userId, roomId } = request.user;
      await prisma.$queryRaw`DELETE FROM User WHERE id = ${userId}`;
      const restUser = await prisma.$queryRaw`SELECT COUNT(*) FROM _RoomToUser WHERE A = ${roomId} `;
      if (!restUser[0]['COUNT(*)']) {
        await prisma.$queryRaw`DELETE FROM Room WHERE id = ${roomId}`;
      }
      pubsub.publish('DELETE_USER', { deleteUser: { id: userId, roomId } });
      return true;
    },
  },

  Subscription: {
    deleteUser: {
      subscribe: withFilter(
        (_: any, __: any, { pubsub }: any) => pubsub.asyncIterator('DELETE_USER'),
        async (payload, variables): Promise<boolean> => {
          if (payload.deleteUser.roomId === variables.roomId) return true;
          return false;
        },
      ),
    },
  },
};
