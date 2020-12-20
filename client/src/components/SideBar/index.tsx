import React from 'react';
import { User } from '@generated/types';
import Footer from '@components/Common/Footer';
import { Theme } from '@styles/Theme';
import styled from 'styled-components';
import Header from './Header';
import UserList from './UserList';

interface StyleProps {
  visible?: boolean;
}

const SideBarWrapper = styled.div<StyleProps>`
  position: fixed;
  top: 0;
  left: 0;
  width: 20%;
  height: 100vh;
  min-width: 280px;
  color: ${(props) => props.theme.whiteColor};
  background-color: ${(props) => props.theme.blueColor};
  border-top-right-radius: 24px;
  border-bottom-right-radius: 24px;
  font-size: 1.2rem;
  z-index: 99;
  transform: ${({ visible }) =>
    visible ? 'translateX(0)' : 'translateX(-100%)'};
  transition: transform 0.3s ease-in-out;

  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    width: 85%;
  }
`;
const FooterWrapper = styled.div`
  position: relative;
  bottom: 1rem;
`;

interface Props {
  visible: boolean;
  users: User[];
}

const SideBar: React.FC<Props> = ({ visible, users }) => {
  return (
    <SideBarWrapper visible={visible}>
      <Header users={users} />
      <UserList users={users} />
      <FooterWrapper>
        <Footer color={Theme.whiteColor} />
      </FooterWrapper>
    </SideBarWrapper>
  );
};

export default SideBar;
