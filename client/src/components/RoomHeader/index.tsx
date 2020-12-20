import React from 'react';
import { User } from '@generated/types';
import styled, { css } from 'styled-components';
import Hamburger from './Hamburger';
import Code from './Code';
import UserAvater from './UserAvater';
import Door from './Door';

const Wrapper = styled.div`
  top: 0;
  right: 0;
  left: 0;
  display: flex;
  align-items: center;
  width: 100%;
  height: 5rem;
  padding: 0 2rem;
  background: ${({ theme }) => theme.whiteColor};
  border-bottom: ${({ theme }) => theme.boxBorder};
  z-index: 1;

  ${({ theme }) =>
    !theme.isLight &&
    css`
      background: #373739;
      color: #e5e5e5;
      border: none;
    `};

  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    height: 3rem;
    padding: 0 1rem;
  }
`;
const RightWrapper = styled.div`
  display: flex;
  justify-content: flex-end;
  align-items: center;
  width: 10rem;
`;

interface Props {
  visible: boolean;
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
  code: string;
  users: User[];
  lang: string;
}

const RoomHeader: React.FC<Props> = ({
  visible,
  setVisible,
  code,
  users,
  lang,
}) => {
  return (
    <Wrapper>
      <Hamburger visible={visible} setVisible={setVisible} />
      <Code code={code} lang={lang} />
      <RightWrapper>
        <UserAvater users={users} />
        <Door />
      </RightWrapper>
    </Wrapper>
  );
};

export default RoomHeader;
