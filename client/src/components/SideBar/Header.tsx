import React from 'react';
import { useLocation } from 'react-router-dom';
import { User } from '@generated/types';
import { getText } from '@constants/localization';
import styled from 'styled-components';

const SideBarHeader = styled.div`
  display: flex;
  align-items: center;
  width: 100%;
  height: 5rem;
  padding: 1.5rem;
  border-bottom: 1px solid white;
  svg {
    fill: ${(props) => props.theme.whiteColor};
  }
`;
const HeaderText = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 5rem;
  width: 100%;
  margin-left: 3rem;
  padding-left: 0.5rem;
  font-weight: 500;
`;

interface Props {
  users: User[];
}

interface LocationState {
  lang: string;
}

const Header: React.FC<Props> = ({ users }) => {
  const location = useLocation<LocationState>();
  const { lang } = location.state;
  const { userList } = getText(lang);
  return (
    <SideBarHeader>
      <HeaderText>
        <div>{userList}</div>
        <div>{users.length}</div>
      </HeaderText>
    </SideBarHeader>
  );
};

export default Header;
