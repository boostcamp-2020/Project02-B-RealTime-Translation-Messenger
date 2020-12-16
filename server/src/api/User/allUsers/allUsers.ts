import { Context } from '@interfaces/context';
import { PrismaClient, User, Room, Message } from '@prisma/client';

const prisma = new PrismaClient();

type result = (User & { rooms: Room[]; messages: Message[] })[];

export default {
  Query: {
    allUsers: (_: result, __: null, { request, isAuthenticated }: Context): Promise<result> => {
      isAuthenticated(request);
      return prisma.user.findMany({
        include: {
          rooms: true,
          messages: true,
        },
      });
    },
  },
};
