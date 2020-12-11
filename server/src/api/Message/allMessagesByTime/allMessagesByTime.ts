import translateText from '@utils/translateText';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

interface Timestamp {
  time: string;
}

interface User {
  id: number;
  avatar: string;
  nickname: string;
  lang: string;
}

interface Message {
  id: number;
  text: string;
  source: string;
  user: User;
}

export default {
  Query: {
    allMessagesByTime: async (
      _: any,
      args: Timestamp,
      { request, isAuthenticated }: any,
    ): Promise<Message[]> => {
      isAuthenticated(request);
      const { time } = args;
      const { roomId } = request.user;
      const Messages: any = await prisma.message.findMany({
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

      const promises = Messages.map(async (message: Message) => {
        message.text = await translateText(message, request.user, users);
      });

      await Promise.all(promises);

      return Messages;
    },
  },
};
