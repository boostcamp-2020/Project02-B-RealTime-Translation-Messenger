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
      const { id, roomId } = request.user;
      await prisma.user.update({
        where: {
          id,
        },
        data: {
          isDeleted: true,
        },
      });
      const restUser = await prisma.user.count({
        where: {
          isDeleted: false,
          rooms: {
            some: {
              id: roomId,
            },
          },
        },
      });
      if (!restUser) {
        await prisma.$queryRaw`delete from user where user.id in (select B from room join _roomtouser on A = ${roomId} AND room.id = A );`;
        await prisma.$queryRaw`DELETE FROM Room WHERE id = ${roomId}`;
        return true;
      }
      pubsub.publish('DELETE_USER', { deleteUser: { id, roomId } });
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
