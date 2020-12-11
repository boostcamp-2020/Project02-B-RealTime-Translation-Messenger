import { getMainDefinition } from '@apollo/client/utilities';
import { ApolloClient, HttpLink, split, InMemoryCache } from '@apollo/client';
import { WebSocketLink } from '@apollo/client/link/ws';
import { setContext } from '@apollo/client/link/context';

const httpLink = new HttpLink({
  uri: `http://${process.env.HOST_URL}/`,
});

const wsLink = new WebSocketLink({
  uri: `ws://${process.env.HOST_URL}/`,
  options: {
    reconnect: true,
    lazy: true,
    connectionParams: () => localStorage.getItem('token'),
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

const authLink = setContext((_, { headers }) => {
  const token = localStorage.getItem('token');
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer ${token}` : '',
    },
  };
});

const client = new ApolloClient({
  link: authLink.concat(link),
  cache: new InMemoryCache(),
});

export default client;
