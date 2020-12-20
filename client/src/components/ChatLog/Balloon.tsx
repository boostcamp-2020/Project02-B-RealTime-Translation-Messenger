import React, { FC } from 'react';
import styled from 'styled-components';
import { Theme } from '@styles/Theme';

interface StyleProps {
  bgColor: string;
  color: string;
  isLeft: boolean;
}

const Container = styled.div<StyleProps>`
  width: 14rem;
  height: fit-content;
  min-height: 3rem;
  margin-left: ${(props) => (props.isLeft ? '0.7rem' : '0')};
  padding: 0.5rem;
  color: ${(props) => props.color};
  background-color: ${(props) => props.bgColor};
  border: 0;
  border-radius: ${({ theme }) => theme.borderRadius};
  font-size: 12px;
  font-weight: 400;
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    flex-direction: column;
    width: fit-content;
    height: fit-content;
    min-height: auto;
    margin-left: 0;
  }
`;

interface Props {
  isOrigin?: boolean;
  text?: string;
  isLeft?: boolean;
}

const Balloon: FC<Props> = ({ isOrigin, text, isLeft = false }) => {
  return (
    <Container
      color={isOrigin ? Theme.whiteColor : Theme.blackColor}
      bgColor={isOrigin ? Theme.blueColor : Theme.lightGrayColor}
      isLeft={isLeft}
    >
      {text}
    </Container>
  );
};

export default Balloon;
