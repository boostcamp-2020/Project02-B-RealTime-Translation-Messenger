import React, { FC } from 'react';
import styled from 'styled-components';
import { Theme } from '@styles/Theme';
import { useUserState } from '@contexts/UserContext';

interface Props {
  author?: string;
  text?: string;
  originText?: string;
  translatedText?: string;
}

interface ContainerProps {
  bgColor: string;
  color: string;
}

const Container = styled.div<ContainerProps>`
  width: 200px;
  height: fit-content;
  min-height: 50px;
  padding: 5px;
  color: ${(props) => props.color};
  background-color: ${(props) => props.bgColor};
  border: 0;
  border-radius: ${(props) => props.theme.borderRadius};
  font-size: 12px;
  font-weight: 400;
`;

const Balloon: FC<Props> = ({ author, text, translatedText, originText }) => {
  const { nickname } = useUserState();
  if (text) {
    if (nickname === author) {
      return (
        <Container color={Theme.whiteColor} bgColor={Theme.blueColor}>
          {text}
        </Container>
      );
    }
    return (
      <Container color={Theme.blackColor} bgColor={Theme.lightGrayColor}>
        {text}
      </Container>
    );
  }
  if (originText) {
    if (nickname === author) {
      return (
        <Container color={Theme.whiteColor} bgColor={Theme.blueColor}>
          {originText}
        </Container>
      );
    }
    return (
      <Container color={Theme.blackColor} bgColor={Theme.lightGrayColor}>
        {originText}
      </Container>
    );
  }
  if (nickname === author) {
    return (
      <Container color={Theme.whiteColor} bgColor={Theme.blueColor}>
        {translatedText}
      </Container>
    );
  }
  return (
    <Container color={Theme.blackColor} bgColor={Theme.lightGrayColor}>
      {translatedText}
    </Container>
  );
};

export default Balloon;
