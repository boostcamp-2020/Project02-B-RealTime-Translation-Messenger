import './env';
import { GraphQLServer } from 'graphql-yoga';

const PORT = process.env.PORT || 4000;

const typeDefs = `
  type Query {
    hello: String!
  } 
`;

const resolvers = {
  Query: {
    hello: (): string => 'hello',
  },
};

const server = new GraphQLServer({ typeDefs, resolvers });

server.start({ port: PORT, cors: { origin: '*' } }, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
