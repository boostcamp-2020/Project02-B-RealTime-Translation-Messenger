import React, { useState, useEffect } from 'react';
import util from '../../utils/utils';
import { avatar as Avatar } from '../../constants/avatar';
import { Refresh } from '../Icons';
import S from './style';

const UserProfile: React.FC = () => {
  const [avatar, setAvatar] = useState(Avatar[0]);
  const [nickname, setNickname] = useState('');

  useEffect(() => {}, [avatar]);

  const onClickRefresh = () => {
    const randomAvatar: string = util.getRandomAvatar();
    setAvatar(randomAvatar);
  };

  const onChangeNickname = (e: React.ChangeEvent<HTMLInputElement>) => {
    setNickname(e.target.value);
  };

  return (
    <S.ProfileWrapper>
      <S.AvatarWrapper>
        <S.Avatar src={avatar} />
        <S.RefreshButton onClick={onClickRefresh}>
          <Refresh size={30} />
        </S.RefreshButton>
      </S.AvatarWrapper>
      <S.NicknameInput placeholder="닉네임 입력" onChange={onChangeNickname} />
    </S.ProfileWrapper>
  );
};

export default UserProfile;
