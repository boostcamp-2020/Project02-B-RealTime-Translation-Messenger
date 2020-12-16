import { Context } from '@interfaces/context';
import { PrismaClient, User, Room, Message } from '@prisma/client';

const prisma = new PrismaClient();

type result = (Room & { users: User[]; messages: Message[] }) | null;

export default {
  Query: {
    roomById: (
      _: Room,
      { id }: { id: number },
      { request, isAuthenticated }: Context,
    ): Promise<result> => {
      isAuthenticated(request);
      return prisma.room.findOne({
        where: {
          id,
        },
        include: {
          users: true,
          messages: true,
        },
      });
    },
  },
};
