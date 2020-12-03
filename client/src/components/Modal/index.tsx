import React, { FC } from 'react';
import styled from 'styled-components';
import { useMutation } from '@apollo/client';
import { useHistory } from 'react-router-dom';
import Button from '@components/Button';
import { ENTER_ROOM } from '@queries/room.queires';
import Overlay from './Overlay';
import Code from './Code';
import {
  EnterRoomResponse,
  MutationEnterRoomArgs,
} from '../../generated/types';

interface Props {
  visible: boolean;
  code?: string;
  onClick?: () => void;
  setVisible?: any; // TODO: 수정하기!
  setCode?: any; // TODO: 수정하기!
}

const Wrapper = styled.div<Props>`
  position: fixed;
  top: 0;
  left: 50%;
  transform: translate(-50%, 10%);
  display: ${(props) => (props.visible ? 'block' : 'none')};
  width: 20vw;
  height: 350px;
  min-width: 400px;
  border-radius: ${(props) => props.theme.borderRadius};
  background-color: ${(props) => props.theme.blackColor};
  overflow: hidden;
  z-index: 2;
`;

const ModalContainer = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
`;

const ModalHeader = styled.div`
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 20%;
  color: ${(props) => props.theme.whiteColor};
`;

const ModalBody = styled.div`
  height: 45%;
  margin-top: 1.5rem;
`;

const ModalFooter = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  height: 35%;
  margin-bottom: 1rem;
  padding: 0 20px;
`;

const Text = styled.div`
  font-size: 15px;
`;

const Modal: FC<Props> = ({ visible, setVisible, setCode }) => {
  const history = useHistory();
  const code = '923186'; // TODO: 추후 수정할 예정 mock data로 입장
  const onClickOverlay = () => {
    setVisible(!visible);
  };

  const [enterRoomMutation] = useMutation<
    { enterRoom: EnterRoomResponse },
    MutationEnterRoomArgs
  >(ENTER_ROOM, {
    variables: {
      nickname: 'naver',
      lang: 'en',
      avatar: 'naver_avatar',
      code,
    },
  });

  const onClickEnterRoom = async () => {
    const { data } = await enterRoomMutation();
    const roomId = data?.enterRoom.roomId;
    const userId = data?.enterRoom.roomId;
    history.push({
      pathname: `/room/${roomId}`,
      state: {
        userId,
        code,
        nickname: 'naver',
        avatar: 'naver_avatar',
        lang: 'en',
      },
    });
  };

  return (
    <>
      <Overlay visible={visible} onClick={onClickOverlay} />
      <Wrapper visible={visible}>
        <ModalContainer>
          <ModalHeader>
            <Text>참여 코드 6자리를 입력해주세요.</Text>
          </ModalHeader>
          <ModalBody>
            <Code setCode={setCode} />
          </ModalBody>
          <ModalFooter>
            <Button text="대화방 입장하기" onClick={onClickEnterRoom} />
          </ModalFooter>
        </ModalContainer>
      </Wrapper>
    </>
  );
};

export default Modal;
