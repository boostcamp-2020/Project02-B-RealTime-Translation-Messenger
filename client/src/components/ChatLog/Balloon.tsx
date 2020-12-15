import React, { FC } from 'react';
import styled from 'styled-components';
import { Theme } from '@styles/Theme';

interface Props {
  isOrigin?: boolean;
  text?: string;
  originText?: string;
  translatedText?: string;
  isLeft?: boolean;
}

interface ContainerProps {
  bgColor: string;
  color: string;
  isLeft: boolean;
}

const Container = styled.div<ContainerProps>`
  width: 100%;
  height: fit-content;
  min-height: 50px;
  margin-left: ${(props) => (props.isLeft ? '0.7rem' : '0')};
  padding: 0.5rem;
  color: ${(props) => props.color};
  background-color: ${(props) => props.bgColor};
  border: 0;
  border-radius: ${(props) => props.theme.borderRadius};
  font-size: 12px;
  font-weight: 400;
`;

const Balloon: FC<Props> = ({
  isOrigin,
  text,
  translatedText,
  originText,
  isLeft = false,
}) => {
  if (text) {
    if (isOrigin) {
      return (
        <Container
          color={Theme.whiteColor}
          bgColor={Theme.blueColor}
          isLeft={isLeft}
        >
          {text}
        </Container>
      );
    }
    return (
      <Container
        color={Theme.blackColor}
        bgColor={Theme.lightGrayColor}
        isLeft={isLeft}
      >
        {text}
      </Container>
    );
  }
  if (originText) {
    if (isOrigin) {
      return (
        <Container
          color={Theme.whiteColor}
          bgColor={Theme.blueColor}
          isLeft={isLeft}
        >
          {originText}
        </Container>
      );
    }
    return (
      <Container
        color={Theme.blackColor}
        bgColor={Theme.lightGrayColor}
        isLeft={isLeft}
      >
        {originText}
      </Container>
    );
  }
  if (isOrigin) {
    return (
      <Container
        color={Theme.whiteColor}
        bgColor={Theme.blueColor}
        isLeft={isLeft}
      >
        {translatedText}
      </Container>
    );
  }
  return (
    <Container
      color={Theme.blackColor}
      bgColor={Theme.lightGrayColor}
      isLeft={isLeft}
    >
      {translatedText}
    </Container>
  );
};

export default Balloon;
