import React from 'react';
import LANGUAGE from '@constants/language';
import util from '@utils/utils';
import { useUserDispatch, useUserState } from '@contexts/UserContext';
import { Refresh } from '@components/Icons';
import S from './style';

const UserProfile: React.FC = () => {
  const dispatch = useUserDispatch();
  const { avatar, nickname, lang } = useUserState();

  const onClickRefresh = () => {
    const randomAvatar: string = util.getRandomAvatar();
    dispatch({
      type: 'SET_AVATAR',
      avatar: randomAvatar,
    });
  };

  const onChangeNickname = (e: React.ChangeEvent<HTMLInputElement>) => {
    dispatch({
      type: 'SET_NICKNAME',
      nickname: e.target.value,
    });
  };

  const onClickLang = (language: string) => {
    dispatch({
      type: 'SET_LANG',
      lang: language,
    });
  };

  return (
    <S.ProfileWrapper>
      <S.AvatarWrapper>
        <S.Avatar src={avatar} />
        <S.RefreshButton onClick={onClickRefresh}>
          <Refresh size={30} />
        </S.RefreshButton>
      </S.AvatarWrapper>
      <S.NicknameInput
        placeholder="닉네임 입력"
        value={nickname}
        onChange={onChangeNickname}
      />
      <S.LanguageWrapper>
        <S.LanguageTitle>언어 선택</S.LanguageTitle>
        <S.LanguageButton
          type="button"
          value="한"
          selected={lang === LANGUAGE.KO}
          onClick={() => onClickLang(LANGUAGE.KO)}
        />
        <S.LanguageButton
          type="button"
          value="En"
          selected={lang === LANGUAGE.EN}
          onClick={() => onClickLang(LANGUAGE.EN)}
        />
      </S.LanguageWrapper>
    </S.ProfileWrapper>
  );
};

export default UserProfile;
