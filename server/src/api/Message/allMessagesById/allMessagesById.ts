import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

interface Args {
  id: number;
  page: number;
}

export default {
  Query: {
    allMessagesById: async (_: any, args: Args, { request, isAuthenticated }: any) => {
      isAuthenticated(request);
      const { id, page } = args;
      const maxId = await prisma.$queryRaw`SELECT MAX(id) from Message WHERE roomId = ${id}`;
      const lastId = maxId[0]['MAX(id)'];
      if (!lastId) return { messages: [], nextPage: null };
      const Messages: any = await prisma.message.findMany({
        where: {
          room: { id },
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
