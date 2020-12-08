import { PrismaClient } from '@prisma/client';
import req from '@utils/request';

const prisma = new PrismaClient();

interface Timestamp {
  time: string;
}

interface Message {
  id: number;
  text: string;
  source: string;
}

export default {
  Query: {
    allMessagesByTime: async (_: any, args: Timestamp, { request, isAuthenticated }: any) => {
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
      const promises = Messages.map(async (message: Message) => {
        const { text, source } = message;
        const { lang: target } = request.user;
        const translatedText = await req(text, source, target); // 번역돌리는 요청
        const texts = {
          originText: text,
          translatedText,
        };
        message.text = JSON.stringify(texts);
      });

      await Promise.all(promises);

      return Messages;
    },
  },
};
