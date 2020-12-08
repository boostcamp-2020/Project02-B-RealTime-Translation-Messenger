import React from 'react';
import { useHistory } from 'react-router-dom';
import CopyToClipboard from 'react-copy-to-clipboard';
import { Hamburger, Copy, Door } from '@components/Icons';
import { AvatarStack, Avatar } from '@primer/components';
import { useMutation } from '@apollo/client';
import { DELETE_USER } from '@/queries/user.queries';
import { User } from '@/generated/types';
import S from './style';

interface Props {
  visible: boolean;
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
  code: string;
  users: User[];
}

const Header: React.FC<Props> = ({ visible, setVisible, code, users }) => {
  const history = useHistory();
  const [deleteUser] = useMutation(DELETE_USER);

  const leaveRoom = async () => {
    await deleteUser();
    localStorage.removeItem('token');
    history.push('/');
  };

  return (
    <S.Wrapper>
      <S.HamburgerButton onClick={() => setVisible(!visible)}>
        <Hamburger size={24} />
      </S.HamburgerButton>
      <CopyToClipboard
        text={code}
        onCopy={() => alert('코드가 복사되었습니다.')}
      >
        <S.CodeWrapper>
          {/* eslint-disable-next-line react/jsx-one-expression-per-line */}
          <S.Code>#{code}</S.Code>
          <Copy size={20} />
        </S.CodeWrapper>
      </CopyToClipboard>
      <S.RightWrapper>
        <AvatarStack alignRight>
          {users.map((user) => (
            <Avatar
              key={user.id}
              style={{ width: '24px', height: '24px' }}
              alt={user.nickname}
              src={user.avatar}
            />
          ))}
        </AvatarStack>
        <S.DoorButton onClick={leaveRoom}>
          <Door size={24} />
        </S.DoorButton>
      </S.RightWrapper>
    </S.Wrapper>
  );
};

export default Header;
