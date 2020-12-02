import React from 'react';
import ReactDOM from 'react-dom';
import { ApolloProvider } from '@apollo/react-hooks';
import App from './App';
import Client from './apollo/Client';

const rootElement = document.getElementById('root');

ReactDOM.render(
  <ApolloProvider client={Client}>
    <App />
  </ApolloProvider>,
  rootElement,
);
