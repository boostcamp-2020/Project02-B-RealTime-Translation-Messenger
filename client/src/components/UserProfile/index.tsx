import React from 'react';
import styled from 'styled-components';
import Language from './Language';
import Nickname from './Nickname';
import Avatar from './Avatar';

const ProfileWrapper = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
`;

interface Props {
  isNicknameValid: boolean;
  setIsNicknameValid: React.Dispatch<React.SetStateAction<boolean>>;
}

const UserProfile: React.FC<Props> = ({
  isNicknameValid,
  setIsNicknameValid,
}) => {
  return (
    <ProfileWrapper>
      <Avatar />
      <Nickname
        isNicknameValid={isNicknameValid}
        setIsNicknameValid={setIsNicknameValid}
      />
      <Language />
    </ProfileWrapper>
  );
};

export default UserProfile;
