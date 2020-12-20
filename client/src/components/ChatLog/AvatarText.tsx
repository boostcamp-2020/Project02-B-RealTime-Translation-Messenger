import React, { FC } from 'react';
import styled from 'styled-components';

interface Props {
  text?: string;
  isAvatarVisible?: boolean;
}

const Text = styled.div<Props>`
  display: ${(props) => (props.isAvatarVisible ? 'inline-block' : 'none')};
  margin-right: 0.3rem;
  color: ${({ theme }) => theme.reverseColor};
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    font-size: 10px;
  }
`;

const AvatarText: FC<Props> = ({ text, isAvatarVisible }) => (
  <Text isAvatarVisible={isAvatarVisible}>{text}</Text>
);

export default AvatarText;
