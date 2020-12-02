import { getMainDefinition } from '@apollo/client/utilities';
import { ApolloClient, HttpLink, split, InMemoryCache } from '@apollo/client';
import { WebSocketLink } from '@apollo/client/link/ws';

const httpLink = new HttpLink({
  uri: `http://${process.env.HOST_URL}/`,
});

const wsLink = new WebSocketLink({
  uri: `ws://${process.env.HOST_URL}/`,
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
