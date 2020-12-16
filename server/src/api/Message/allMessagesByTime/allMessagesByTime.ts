import { Context } from '@interfaces/context';
import translateText from '@utils/translateText';
import { PrismaClient, Message } from '@prisma/client';

const prisma = new PrismaClient();

interface Timestamp {
  time: string;
}

export default {
  Query: {
    allMessagesByTime: async (
      _: Message,
      args: Timestamp,
      { request, isAuthenticated }: Context,
    ): Promise<Message[]> => {
      isAuthenticated(request);
      const { time } = args;
      const { roomId } = request.user;
      const Messages = await prisma.message.findMany({
        where: {
          AND: [
            {
              room: {
                id: roomId,
              },
            },
            {
              createdAt: {
                gt: new Date(+time),
              },
            },
          ],
        },
        include: {
          user: true,
        },
      });

      const users = await prisma.room
        .findOne({
          where: {
            id: roomId,
          },
        })
        .users();

      const promises = Messages.map(async (message) => {
        message.text = await translateText(message, request.user, users);
      });

      await Promise.all(promises);

      return Messages;
    },
  },
};
