import { getMainDefinition } from 'apollo-utilities';
import { split } from 'apollo-boost';
import { ApolloClient } from 'apollo-client';
import { InMemoryCache } from 'apollo-cache-inmemory';
import { HttpLink } from 'apollo-link-http';
import { WebSocketLink } from 'apollo-link-ws';

const httpLink = new HttpLink({
  uri: `http://${process.env.HOST_URL}`,
});

const wsLink = new WebSocketLink({
  uri: `ws://${process.env.HOST_URL}`,
  options: {
    reconnect: true,
  },
});

const link = split(
  ({ query }) => {
    const definition = getMainDefinition(query);
    return (
      definition.kind === 'OperationDefinition' &&
      definition.operation === 'subscription'
    );
  },
  wsLink,
  httpLink,
);

const client = new ApolloClient({
  link,
  cache: new InMemoryCache(),
});

export default client;
