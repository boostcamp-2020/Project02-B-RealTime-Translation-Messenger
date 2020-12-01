import React from 'react';
import { Route } from 'react-router-dom';
import Home from './Home';
import Room from './Room';

const Routes: React.FC = () => {
  return (
    <>
      <Route exact path="/" component={Home} />
      <Route exact path="/room/:id" component={Room} />
    </>
  );
};

export default Routes;
