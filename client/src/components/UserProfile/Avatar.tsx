import React from 'react';
import styled from 'styled-components';
import { useUserDispatch, useUserState } from '@/contexts/UserContext';
import util from '@utils/utils';
import { Refresh } from '../Common/Icons';

const AvatarWrapper = styled.div`
  position: relative;
  width: 14.5rem;
  height: 14.5rem;
  background: ${({ theme }) => theme.whiteColor};
  border: ${({ theme }) => theme.boxBorder};
  border-radius: 50%;
`;
const AvatarImage = styled.img`
  width: inherit;
  height: inherit;
  background: none;
`;
const RefreshButton = styled.button`
  position: absolute;
  display: flex;
  align-items: center;
  justify-content: center;
  bottom: 0.8rem;
  right: 0.8rem;
  padding: 0.5rem;
  background: ${({ theme }) => theme.grayColor};
  border-radius: 50%;
  svg {
    fill: ${({ theme }) => theme.whiteColor};
  }
`;

const Avatar: React.FC = () => {
  const { avatar } = useUserState();
  const dispatch = useUserDispatch();

  const onClickRefresh = () => {
    const randomAvatar: string = util.getRandomAvatar();
    dispatch({
      type: 'SET_AVATAR',
      avatar: randomAvatar,
    });
  };

  return (
    <AvatarWrapper>
      <AvatarImage src={avatar} />
      <RefreshButton onClick={onClickRefresh}>
        <Refresh size={30} />
      </RefreshButton>
    </AvatarWrapper>
  );
};

export default Avatar;
