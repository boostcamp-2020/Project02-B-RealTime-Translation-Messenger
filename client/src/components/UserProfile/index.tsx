import React from 'react';
import { Refresh } from '../Icons';
import S from './style';

const UserProfile: React.FC = () => {
  return (
    <S.ProfileWrapper>
      <S.AvatarWrapper>
        <S.Avatar src="https://user-images.githubusercontent.com/26537048/100733385-72cc1d80-3411-11eb-9f23-e60f603d019a.png" />
        <S.RefreshButton>
          <Refresh size={30} />
        </S.RefreshButton>
      </S.AvatarWrapper>
      <S.NicknameInput placeholder="닉네임 입력" />
    </S.ProfileWrapper>
  );
};

export default UserProfile;
