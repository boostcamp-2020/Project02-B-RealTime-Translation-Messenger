import React, { FC } from 'react';
import styled from 'styled-components';
import { Theme } from '@styles/Theme';

const { blueColor } = Theme;

interface StyleProps {
  isValid: boolean | undefined;
}

const Container = styled.button<StyleProps>`
  width: 100%;
  height: 4rem;
  margin: 0.3rem 0;
  padding: 15px 0px;
  color: white;
  border: 0;
  background-color: ${(props) => props.color};
  border-radius: ${(props) => props.theme.borderRadius};
  font-size: 20px;
  font-weight: 400;
  text-align: center;

  opacity: ${(props) => (props.isValid ? '' : '0.6')};
`;

interface Props {
  text: string;
  color?: string;
  onClick?: () => void;
  isValid?: boolean;
}

const Button: FC<Props> = ({ text, color, onClick, isValid }) => (
  <Container onClick={onClick} color={color} isValid={isValid}>
    {text}
  </Container>
);

Button.defaultProps = {
  text: '',
  color: blueColor,
  isValid: true,
};

export default Button;
