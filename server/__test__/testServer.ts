import { PubSub } from 'graphql-yoga';
import { ApolloServer } from 'apollo-server';
import schema from '../src/schema';
import { createTestClient } from 'apollo-server-testing';
import dotenv from 'dotenv';
import isAuthenticated from '../src/middlewares/isAuthenticated';
import { testUser } from './mock.json';

dotenv.config();

const RequestUser = {
  user: testUser,
};

const pubsub = new PubSub();

const server = new ApolloServer({
  schema,
  context: () => ({
    request: RequestUser,
    isAuthenticated,
    pubsub,
  }),
});

const { query, mutate } = createTestClient(server);

export { query, mutate };
