import React, { FC } from 'react';
import styled from 'styled-components';

interface Props {
  placeholder?: string;
  required?: boolean;
  value?: string;
  onChange?: () => void;
  type?: string;
}

const Container = styled.input`
  width: 15%;
  height: 100px;
  padding: 0px 15px;
  border: 0;
  border-radius: ${(props) => props.theme.borderRadiusSmall};
  color: ${(props) => props.theme.blackColor};
  background-color: ${(props) => props.theme.whiteColor};
  font-size: 25px;
  font-weight: 600;
  text-align: center;
`;

const Input: FC<Props> = ({ placeholder, required, value, onChange, type }) => (
  <Container
    placeholder={placeholder}
    required={required}
    value={value}
    onChange={onChange}
    type={type}
  />
);

Input.defaultProps = {
  type: 'text',
  required: true,
};

export default Input;
