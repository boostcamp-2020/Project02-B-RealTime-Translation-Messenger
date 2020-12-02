import React from 'react';
import ReactDOM from 'react-dom';
import { ApolloProvider } from 'react-apollo';
import { ApolloProvider as ApolloHooksProvider } from 'react-apollo-hooks';
import App from './App';
import Client from './apollo/client';

const rootElement = document.getElementById('root');

ReactDOM.render(
  <ApolloProvider client={Client}>
    <ApolloHooksProvider client={Client}>
      <App />
    </ApolloHooksProvider>
  </ApolloProvider>,
  rootElement,
);
