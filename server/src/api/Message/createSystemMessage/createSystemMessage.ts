import { PrismaClient } from '@prisma/client';
import TRIGGER from '@utils/trigger';

const prisma = new PrismaClient();

export default {
  Mutation: {
    createSystemMessage: async (
      _: any,
      { source }: { source: string },
      { request, pubsub }: any,
    ): Promise<boolean> => {
      const { id, nickname, avatar, lang, roomId } = request.user;
      const newMessage = await prisma.message.create({
        data: {
          text: `${nickname}님이 ${source === 'in' ? '들어왔습니다' : '나갔습니다'}`,
          source,
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

      pubsub.publish(TRIGGER.NEW_MESSAGE, { newMessage });
      if (source === 'in') {
        pubsub.publish(TRIGGER.NEW_USER, { newUser: { id, nickname, avatar, lang, roomId } });
        return true;
      }
      pubsub.publish(TRIGGER.DELETE_USER, { deleteUser: { id, roomId } });
      return true;
    },
  },
};
