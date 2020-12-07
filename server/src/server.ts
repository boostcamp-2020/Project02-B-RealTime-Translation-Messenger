import './env';
import { GraphQLServer, PubSub } from 'graphql-yoga';
import { authenticateJwt } from './middlewares/passport';
import isAuthenticated from './middlewares/isAuthenticated';
import schema from './schema';
import logger from 'morgan';
import 'module-alias/register';

const PORT = process.env.PORT || 4000;

const pubsub = new PubSub();

const server = new GraphQLServer({
  schema,
  context: ({ request }) => ({ request, isAuthenticated, pubsub }),
});

server.express.use(logger('dev'));
server.express.use(authenticateJwt);

server.start({ port: PORT, cors: { origin: '*' } }, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
