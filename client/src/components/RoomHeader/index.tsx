import React from 'react';
import { useHistory } from 'react-router-dom';
import CopyToClipboard from 'react-copy-to-clipboard';
import { Copy, Door } from '@components/Common/Icons';
import Toast from '@components/Common/Toast';
import { AvatarStack, Avatar } from '@primer/components';
import { useMutation } from '@apollo/client';
import { DELETE_USER } from '@queries/user.queries';
import { CREATE_SYSTEM_MESSAGE } from '@queries/messege.queries';
import { User } from '@generated/types';
import client, { wsClient } from '@/apollo/Client';
import floatToast from '@utils/toast';
import styled, { css } from 'styled-components';

interface StyleProps {
  visible?: boolean;
}

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
const HamburgerWrapper = styled.div`
  width: 10rem;
`;
const HamburgerButton = styled.button<StyleProps>`
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  height: 1.5rem;
  padding: 0;
  background: transparent;
  z-index: 10;

  div {
    position: relative;
    width: 1.5rem;
    height: 0.1rem;
    background: ${({ theme, visible }) =>
      // eslint-disable-next-line no-nested-ternary
      visible
        ? theme.whiteColor
        : theme.isLight
        ? theme.blackColor
        : '#545759'};
    border-radius: 10px;
    transition: all 0.3s linear;
    transform-origin: 0.5px;
    z-index: 100;

    :nth-child(1) {
      transform: ${({ visible }) => (visible ? 'rotate(45deg)' : 'rotate(0)')};
    }
    :nth-child(2) {
      opacity: ${({ visible }) => (visible ? '0' : '1')};
      transform: ${({ visible }) =>
        visible ? 'translateX(20px)' : 'translateX(0)'};
    }
    :nth-child(3) {
      transform: ${({ visible }) => (visible ? 'rotate(-45deg)' : 'rotate(0)')};
    }
  }
`;
const CodeWrapper = styled.div`
  display: flex;
  margin: 0 auto;
  cursor: pointer;
  svg {
    fill: ${({ theme }) => (theme.isLight ? theme.blackColor : '#e5e5e5')};
  }
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    svg {
      width: 15px;
      height: 15px;
    }
  }
`;
const Code = styled.div`
  margin-right: 0.3rem;
  font-size: 20px;
  font-weight: 500;
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    font-size: 14px;
  }
`;
const RightWrapper = styled.div`
  display: flex;
  justify-content: flex-end;
  align-items: center;
  width: 10rem;
`;
const DoorButton = styled.button`
  display: flex;
  align-items: center;
  width: 24px;
  height: 24px;
  margin-left: 1rem;
  svg {
    fill: ${({ theme }) => (theme.isLight ? theme.blackColor : '#545759')};
  }
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    margin-top: 3px;
    margin-left: 0.5rem;
    svg {
      width: 15px;
      height: 15px;
    }
  }
`;

interface Props {
  visible: boolean;
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
  code: string;
  users: User[];
}

const RoomHeader: React.FC<Props> = ({ visible, setVisible, code, users }) => {
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
    wsClient.close();
  };

  const toast = () => {
    floatToast('.copy-toast');
  };

  const onClickHamburger = () => {
    setVisible(!visible);
  };

  return (
    <>
      <Wrapper>
        <HamburgerWrapper>
          <HamburgerButton visible={visible} onClick={onClickHamburger}>
            <div />
            <div />
            <div />
          </HamburgerButton>
        </HamburgerWrapper>
        <CopyToClipboard text={code} onCopy={toast}>
          <CodeWrapper>
            {/* eslint-disable-next-line react/jsx-one-expression-per-line */}
            <Code>#{code}</Code>
            <Copy size={20} />
          </CodeWrapper>
        </CopyToClipboard>
        <RightWrapper>
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
          <DoorButton onClick={leaveRoom}>
            <Door size={24} />
          </DoorButton>
        </RightWrapper>
        <Toast className="copy-toast" text="코드가 복사되었습니다!" />
      </Wrapper>
    </>
  );
};

export default RoomHeader;
