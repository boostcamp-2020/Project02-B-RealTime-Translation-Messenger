import React, { FC } from 'react';
import styled from 'styled-components';
import { Theme } from '@styles/Theme';

interface Props {
  text?: string;
  bgColor: string;
  color: string;
}

const Container = styled.div<Props>`
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px;
  width: 300px;
  height: 300px;
  background: ${(props) => props.bgColor};
  color: ${(props) => props.color};
  border-radius: ${(props) => props.theme.borderRadiusSmall};
  font-size: 12px;
  &:after {
    border-top: 0px solid transparent;
    border-left: 10px solid transparent;
    border-right: 10px solid transparent;
    border-bottom: 10px solid ${(props) => props.color};
    content: '';
    position: absolute;
    top: -10px;
    left: 140px;
  }
`;

const Bubble: FC<Props> = ({ text, bgColor, color }) => (
  <Container bgColor={bgColor} color={color}>
    {text}
  </Container>
);

Bubble.defaultProps = {
  text: '',
  bgColor: Theme.blackColor,
  color: Theme.whiteColor,
};

export default Bubble;
