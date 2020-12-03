import React, { FC, useState, useEffect } from 'react';
import styled from 'styled-components';
import { useUserDispatch } from '@contexts/UserContext';
import Input from './Input';

interface Props {
  visible?: boolean;
}

const Container = styled.div`
  display: flex;
  width: 100%;
  height: 100%;
  padding: 10px;
  justify-content: space-around;
  align-items: center;
`;

const Code: FC<Props> = ({ visible }) => {
  const dispatch = useUserDispatch();
  const [pinValues, setPinValues] = useState<string[]>(new Array(6).fill(''));

  const onChangeInput = (
    event: React.ChangeEvent<HTMLInputElement>,
    index: number,
  ) => {
    const { value } = event.target;
    const newValues = [...pinValues];
    newValues[index] = value;
    setPinValues(newValues);
    const newTarget: any = event.target.nextElementSibling; // TODO: any 수정
    if (value) {
      if (newTarget) {
        newTarget.focus();
      }
      dispatch({
        type: 'SET_CODE',
        code: newValues.join(''),
      });
    }
  };

  useEffect(() => {
    if (!visible) setPinValues(new Array(6).fill(''));
  }, [visible]);

  return (
    <Container>
      {Array.from(Array(6).keys()).map((index) => (
        <Input
          key={index}
          name="codePin"
          maxLength={1}
          onChange={onChangeInput}
          index={index}
          value={pinValues[index]}
        />
      ))}
    </Container>
  );
};

export default Code;
