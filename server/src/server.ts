import { PrismaClient } from '@prisma/client';
import './env';
import { GraphQLServer, PubSub } from 'graphql-yoga';
import { authenticateJwt } from './middlewares/passport';
import isAuthenticated from './middlewares/isAuthenticated';
import schema from './schema';
import logger from 'morgan';
import 'module-alias/register';
import { verify } from 'jsonwebtoken';

const PORT = process.env.PORT || 4000;

const prisma = new PrismaClient();
const pubsub = new PubSub();
const server = new GraphQLServer({
  schema,
  context: ({ request, connection }) => ({ request, connection, isAuthenticated, pubsub }),
});

server.express.use(logger('dev'));
server.express.use(authenticateJwt);

interface ConnectionParams {
  authToken: string;
}

server.start(
  {
    port: PORT,
    cors: { origin: true },
    endpoint: '/graphql',
    subscriptions: {
      path: '/graphql',
      onConnect: async (connectionParams: ConnectionParams) => {
        const { authToken } = connectionParams;
        const user: any = verify(authToken, process.env.JWT_SECRET_KEY as string);
        const findUser = await prisma.user.findOne({ where: { id: user.id } });
        if (!findUser) throw new Error('Not valid user token');
        return { user: { ...findUser, roomId: user.roomId } };
      },
    },
  },
  () => {
    console.log(`Server running on http://localhost:${PORT}`);
  },
);
