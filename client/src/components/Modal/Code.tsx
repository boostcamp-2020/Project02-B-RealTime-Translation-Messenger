import React, { FC } from 'react';
import styled from 'styled-components';
import Input from './Input';

interface Props {
  code?: string;
  setCode?: any; // TODO: 수정하기!
}

const Container = styled.div`
  display: flex;
  width: 100%;
  height: 100%;
  padding: 10px;
  justify-content: space-around;
  align-items: center;
`;

const Code: FC<Props> = ({ code, setCode }) => {
  const onChangeInput = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = event.target;
    const newTarget: any = event.target.nextElementSibling;
    if (value) {
      if (newTarget) {
        newTarget.focus();
      }
      setCode(code + value);
    }
  };

  return (
    <Container>
      {Array.from(Array(6).keys()).map((index) => (
        <Input
          key={index}
          name="codePin"
          maxLength={1}
          onChange={onChangeInput}
        />
      ))}
    </Container>
  );
};

export default Code;
