import React, { FC } from 'react';
import styled from 'styled-components';
import Input from './Input';

const Container = styled.div`
  display: flex;
  width: 100%;
  height: 100%;
  padding: 10px;
  justify-content: space-around;
  align-items: center;
`;

const Code: FC = () => {
  return (
    <Container>
      <Input />
      <Input />
      <Input />
      <Input />
      <Input />
      <Input />
    </Container>
  );
};

export default Code;
