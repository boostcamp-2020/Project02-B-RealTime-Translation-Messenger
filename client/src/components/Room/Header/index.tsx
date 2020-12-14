import React from 'react';
import { useHistory } from 'react-router-dom';
import CopyToClipboard from 'react-copy-to-clipboard';
import { Copy, Door } from '@components/Icons';
import { AvatarStack, Avatar } from '@primer/components';
import { useMutation } from '@apollo/client';
import { DELETE_USER } from '@queries/user.queries';
import { User } from '@generated/types';
import client from '@/apollo/Client';
import { CREATE_SYSTEM_MESSAGE } from '@/queries/messege.queries';
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

  const [createSystemMessageMutation] = useMutation(CREATE_SYSTEM_MESSAGE, {
    variables: { source: 'out' },
  });

  const leaveRoom = async () => {
    createSystemMessageMutation();
    history.push('/');
    await deleteUser();
    localStorage.removeItem('token');
    client.resetStore();
  };

  const toast = () => {
    const toastMsg: Element = document.querySelector('.toast')!;

    if (!toastMsg.classList.contains('reveal')) {
      setTimeout(() => {
        document.querySelector('.toast')!.classList.remove('reveal');
      }, 1000);
    }

    toastMsg.classList.add('reveal');
  };

  const onClickHamburger = () => {
    setVisible(!visible);
  };

  return (
    <S.Wrapper>
      <S.HamburgerWrapper>
        <S.HamburgerButton visible={visible} onClick={onClickHamburger}>
          <div />
          <div />
          <div />
        </S.HamburgerButton>
      </S.HamburgerWrapper>
      <CopyToClipboard text={code} onCopy={toast}>
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
              style={{
                width: '24px',
                height: '24px',
                backgroundColor: `${(props: any) => props.theme.whiteColor}`,
              }}
              alt={user.nickname}
              src={user.avatar}
            />
          ))}
        </AvatarStack>
        <S.DoorButton onClick={leaveRoom}>
          <Door size={24} />
        </S.DoorButton>
      </S.RightWrapper>
      <S.Toast className="toast">코드가 복사되었습니다!</S.Toast>
    </S.Wrapper>
  );
};

export default Header;
