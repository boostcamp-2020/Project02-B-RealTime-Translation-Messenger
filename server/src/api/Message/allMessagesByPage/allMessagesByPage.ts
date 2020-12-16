import { Context } from '@interfaces/context';
import { PrismaClient, Message, User } from '@prisma/client';
import translateText from '@utils/translateText';

const prisma = new PrismaClient();

interface Pagination {
  page: number;
}

interface AllMessages {
  messages: (Message & { user: User })[];
  nextPage: number | null;
}

export default {
  Query: {
    allMessagesByPage: async (
      _: AllMessages,
      args: Pagination,
      { request, isAuthenticated }: Context,
    ): Promise<AllMessages> => {
      isAuthenticated(request);
      const { page } = args;
      const { roomId } = request.user;
      const maxId = await prisma.$queryRaw`SELECT MAX(id) from Message WHERE roomId = ${roomId}`;
      const lastId = maxId[0]['MAX(id)'];
      if (!lastId) return { messages: [], nextPage: null };
      const Messages = await prisma.message.findMany({
        where: {
          room: { id: roomId },
        },
        take: -10,
        skip: 10 * (page - 1),
        cursor: {
          id: lastId,
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
        const { source } = message;
        if (source !== 'in' && source !== 'out') {
          message.text = await translateText(message, request.user, users);
        }
      });

      await Promise.all(promises);

      if (Messages.length === 10) {
        return {
          messages: Messages,
          nextPage: page + 1,
        };
      }
      return {
        messages: Messages,
        nextPage: null,
      };
    },
  },
};
