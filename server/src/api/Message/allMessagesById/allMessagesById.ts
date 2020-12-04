import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    allMessagesById: (_: any, { id }: { id: number }) =>
      prisma.message.findMany({
        where: {
          room: { id },
        },
        include: {
          user: true,
        },
      }),
  },
};
