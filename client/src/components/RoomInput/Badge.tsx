import React, { FC } from 'react';
import styled from 'styled-components';

interface Props {
  textLength: number;
}

const Container = styled.span<Props>`
  position: absolute;
  top: 6.5rem;
  width: 50px;
  margin: 0.2rem 0;
  padding: 5px;
  color: ${(props) => props.theme.whiteColor};
  border: 0;
  background-color: ${(props) =>
    props.textLength === 190 ? '#d6067c' : props.theme.blueColor};
  border-radius: ${(props) => props.theme.borderRadiusSmall};
  font-size: 8px;
  text-align: center;
  @media (max-width: ${(props) => props.theme.mediaSize}) {
    top: 10.5rem;
  }
`;

const Button: FC<Props> = ({ textLength }) => (
  <Container textLength={textLength}>
    {textLength}
    /190
  </Container>
);

Button.defaultProps = {
  textLength: 0,
};

export default Button;
