import React, { FC, useEffect } from 'react';
import styled from 'styled-components';
import Input from './Input';

interface Props {
  visible?: boolean;
  pinValue?: string;
  setPinValue: React.Dispatch<React.SetStateAction<string>>;
}

const Container = styled.div`
  display: flex;
  width: 100%;
  height: 100%;
  padding: 10px;
  justify-content: space-around;
  align-items: center;
`;

const Code: FC<Props> = ({ visible, pinValue, setPinValue }) => {
  useEffect(() => {
    if (!visible) setPinValue('');
  }, [visible]);

  return (
    <Container>
      <Input value={pinValue} onChange={setPinValue} numInputs={6} />
    </Container>
  );
};

export default Code;
