import React, { FC } from 'react';
import styled from 'styled-components';

interface Props {
  size?: number;
  profile?: string;
}

const Container = styled.img<Props>`
  width: ${(props) => props.size}px;
  height: ${(props) => props.size}px;
  border: 1px solid ${(props) => props.theme.grayColor};
  border-radius: 50%;
`;

const Avatar: FC<Props> = ({ size, profile }) => {
  return <Container size={size} src={profile} />;
};

export default Avatar;
