import { PrismaClient } from '@prisma/client';
import { withFilter } from 'graphql-subscriptions';
import TRIGGER from '@utils/trigger';

const prisma = new PrismaClient();

export default {
  Mutation: {
    deleteUser: async (
      _: any,
      __: any,
      { pubsub, request, isAuthenticated }: any,
    ): Promise<boolean> => {
      isAuthenticated(request);

      const { id, nickname, roomId } = request.user;

      const newMessage = await prisma.message.create({
        data: {
          text: `${nickname}님이 나갔습니다`,
          source: 'out',
          user: {
            connect: {
              id,
            },
          },
          room: {
            connect: {
              id: roomId,
            },
          },
        },
        include: {
          user: true,
        },
      });


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

        include: {
          user: true,
        },
      });

      if (!restUser) {
        await prisma.$queryRaw`delete from user where user.id in (select B from room join _roomtouser on A = ${roomId} AND room.id = A );`;

        await prisma.$queryRaw`DELETE FROM Room WHERE id = ${roomId}`;
        return true;
      }


      pubsub.publish(TRIGGER.NEW_MESSAGE, { newMessage });

      pubsub.publish(TRIGGER.DELETE_USER, { deleteUser: { id, roomId } });

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
