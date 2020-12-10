import generateToken from '@utils/generateToken';
import { PrismaClient } from '@prisma/client';
import TRIGGER from '@utils/trigger';

const prisma = new PrismaClient();

interface EnterInfo {
  nickname: string;
  avatar: string;
  lang: string;
  code: string;
  token: string;
}

export default {
  Mutation: {
    enterRoom: async (
      _: any,
      { nickname, avatar, lang, code }: EnterInfo,
      { pubsub }: any,
    ): Promise<{ userId: number; roomId: number; token: string }> => {
      const newUser = await prisma.user.create({
        data: {
          nickname,
          lang,
          avatar,
          rooms: {
            connect: { code },
          },
        },
        include: { rooms: true },
      });
      const jwtToken = generateToken(newUser, newUser.rooms[0].id);

      const newMessage = await prisma.message.create({
        data: {
          text: `${nickname}님이 들어왔습니다`,
          source: 'in',
          user: {
            connect: {
              id: newUser.id,
            },
          },
          room: {
            connect: {
              id: newUser.rooms[0].id,
            },
          },
        },
        include: {
          user: true,
        },
      });

      pubsub.publish(TRIGGER.NEW_MESSAGE, { newMessage });
      pubsub.publish(TRIGGER.NEW_USER, { newUser });

      return { userId: newUser.id, roomId: newUser.rooms[0].id, token: jwtToken };
    },
  },
};
