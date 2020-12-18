import React, { FC } from 'react';
import styled from 'styled-components';

interface Props {
  size?: number;
  profile?: string;
  isAvatarVisible?: boolean;
}

const Container = styled.img<Props>`
  visibility: ${(props) => (props.isAvatarVisible ? 'visible' : 'hidden')};
  width: ${(props) => props.size}px;
  height: ${(props) => props.size}px;
  border: 1px solid ${(props) => props.theme.grayColor};
  border-radius: 50%;
`;

const Avatar: FC<Props> = ({ size, profile, isAvatarVisible }) => {
  return (
    <Container isAvatarVisible={isAvatarVisible} size={size} src={profile} />
  );
};

export default Avatar;
