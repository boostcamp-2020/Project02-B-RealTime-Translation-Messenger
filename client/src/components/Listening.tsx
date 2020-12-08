import styled from 'styled-components';
import React, { FC } from 'react';
import { Microphone } from './Icons';

interface Props {
  isListening: boolean;
  setIsListening: React.Dispatch<React.SetStateAction<boolean>>;
  setText: React.Dispatch<React.SetStateAction<string>>;
}

const ListeningContainer = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 50px;
  height: 50px;
  border: 5px solid #3498db;
  border-radius: 50%;
  background-color: ${(props) => props.theme.blueColor};
  svg {
    fill: white;
  }
  -webkit-animation: borderScale 1s infinite ease-in-out;
  animation: borderScale 1s infinite ease-in-out;

  @-webkit-keyframes borderScale {
    0% {
      border: 1px solid white;
    }
    50% {
      border: 8px solid #3498db;
    }
    100% {
      border: 1px solid white;
    }
  }

  @keyframes borderScale {
    0% {
      border: 1px solid white;
    }
    50% {
      border: 8px solid #3498db;
    }
    100% {
      border: 1px solid white;
    }
  }
`;

const Container = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background-color: ${(props) => props.theme.blueColor};
  svg {
    fill: white;
  }
`;

const Button: FC<Props> = ({ isListening, setIsListening }) => {
  const onClickMic = () => {
    setIsListening(!isListening);
  };
  return (
    <>
      {isListening ? (
        <ListeningContainer onClick={onClickMic}>
          <Microphone size={30} />
        </ListeningContainer>
      ) : (
        <Container onClick={onClickMic}>
          <Microphone size={30} />
        </Container>
      )}
    </>
  );
};

export default Button;
