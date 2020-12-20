import { Context } from '@interfaces/context';
import { PrismaClient } from '@prisma/client';
import { withFilter } from 'graphql-subscriptions';
import TRIGGER from '@utils/trigger';

const prisma = new PrismaClient();

export default {
  Mutation: {
    deleteUser: async (
      _: boolean,
      __: null,
      { request, isAuthenticated }: Context,
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
        await prisma.$queryRaw`delete from User where User.id in (select B from Room join _RoomToUser on A = ${roomId} AND Room.id = A );`;
        await prisma.$queryRaw`DELETE FROM Room WHERE id = ${roomId}`;
      }
      return true;
    },
  },

  Subscription: {
    deleteUser: {
      subscribe: withFilter(
        (_: boolean, __: null, { pubsub }: Context) => pubsub.asyncIterator(TRIGGER.DELETE_USER),
        async (payload, variables, context): Promise<boolean> => {
          const { roomId } = context.connection.context.user;
          if (payload.deleteUser.roomId === roomId) return true;
          return false;
        },
      ),
    },
  },
};
