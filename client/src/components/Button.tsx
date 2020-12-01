import React, { FC } from 'react';
import styled from 'styled-components';
import { Theme } from '../styles/Theme';

interface Props {
  text: string;
  color?: string;
  onClick?: () => void;
}

const { blueColor } = Theme;

const Container = styled.button`
  width: 100%;
  padding: 15px 0px;
  color: white;
  border: 0;
  background-color: ${(props) => props.color};
  border-radius: ${(props) => props.theme.borderRadius};
  font-size: 20px;
  font-weight: 600;
  text-align: center;
`;

const Button: FC<Props> = ({ text, color, onClick }) => (
  <Container onClick={onClick} color={color}>
    {text}
  </Container>
);

Button.defaultProps = {
  text: '',
  color: blueColor,
};

export default Button;
