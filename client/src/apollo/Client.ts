import { getMainDefinition } from '@apollo/client/utilities';
import { ApolloClient, HttpLink, split, InMemoryCache } from '@apollo/client';
import { WebSocketLink } from '@apollo/client/link/ws';
import { setContext } from '@apollo/client/link/context';

const httpsUri = process.env.HTTPS_URI || 'http://localhost:4000/graphql';
const wssUri = process.env.WSS_URI || 'ws://localhost:4000/graphql';

const httpLink = new HttpLink({
  uri: httpsUri,
});

const wsLink = new WebSocketLink({
  uri: wssUri,
  options: {
    reconnect: true,
    lazy: true,
    connectionParams: () => ({ authToken: localStorage.getItem('token') }),
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
