import './env';
import { GraphQLServer } from 'graphql-yoga';
import schema from './schema';
import logger from 'morgan';
import 'module-alias/register';

const PORT = process.env.PORT || 4000;

const server = new GraphQLServer({ schema });

server.express.use(logger('dev'));

server.start({ port: PORT, cors: { origin: '*' } }, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
