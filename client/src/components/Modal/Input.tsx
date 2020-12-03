import React, { FC } from 'react';
import styled from 'styled-components';

interface Props {
  placeholder?: string;
  required?: boolean;
  index?: number;
  value?: string;
  onChange?: (
    event: React.ChangeEvent<HTMLInputElement>,
    index: number,
  ) => void;
  type?: string;
  maxLength?: number;
  name?: string;
}

const Container = styled.input`
  width: 15%;
  height: 80px;
  padding: 0px 15px;
  border: 0;
  border-radius: ${(props) => props.theme.borderRadiusSmall};
  color: ${(props) => props.theme.blackColor};
  background-color: ${(props) => props.theme.whiteColor};
  font-size: 25px;
  font-weight: 600;
  text-align: center;
`;

const Input: FC<Props> = ({
  placeholder,
  required,
  index,
  value,
  onChange,
  type,
  maxLength,
  name,
}) => {
  return (
    <Container
      placeholder={placeholder}
      required={required}
      value={value}
      onChange={(e) => onChange && onChange(e, index as number)}
      type={type}
      maxLength={maxLength}
      name={name}
    />
  );
};

Input.defaultProps = {
  type: 'text',
  required: true,
  name: '',
};

export default Input;
