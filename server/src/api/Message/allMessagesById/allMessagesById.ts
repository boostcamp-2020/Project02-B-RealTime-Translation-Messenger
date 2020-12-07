import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    allMessagesById: async (_: any, { id, page }: { id: number; page: number }) => {
      const maxId = await prisma.$queryRaw`SELECT MAX(id) from Message WHERE roomId = ${id}`;
      const lastId = maxId[0]['MAX(id)'];
      const Messages: any = await prisma.message.findMany({
        where: {
          room: { id },
        },
        take: -10,
        skip: 10 * (page - 1),
        cursor: {
          id: lastId,
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
