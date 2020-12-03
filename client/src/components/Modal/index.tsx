import React, { FC } from 'react';
import styled from 'styled-components';
import { useMutation } from '@apollo/client';
import { useHistory } from 'react-router-dom';
import Button from '@components/Button';
import { ENTER_ROOM } from '@queries/room.queires';
import { EnterRoomResponse, MutationEnterRoomArgs } from '@generated/types';
import { useUserState, useUserDispatch } from '@contexts/UserContext';
import { useLocalizationState } from '@/contexts/localizationContext';
import Overlay from './Overlay';
import Code from './Code';

interface Props {
  visible: boolean;
  onClick?: () => void;
  setVisible?: React.Dispatch<React.SetStateAction<boolean>>;
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

const Modal: FC<Props> = ({ visible, setVisible }) => {
  const history = useHistory();
  const { nickname, avatar, lang, code } = useUserState();
  const dispatch = useUserDispatch();
  const { enterCode, submitCode } = useLocalizationState();

  const onClickOverlay = () => {
    if (setVisible) setVisible(!visible);
    dispatch({
      type: 'SET_CODE',
      code: '',
    });
  };

  const [enterRoomMutation] = useMutation<
    { enterRoom: EnterRoomResponse },
    MutationEnterRoomArgs
  >(ENTER_ROOM, {
    variables: {
      nickname,
      lang,
      avatar,
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
        nickname,
        avatar,
        lang,
      },
    });
  };

  return (
    <>
      <Overlay visible={visible} onClick={onClickOverlay} />
      <Wrapper visible={visible}>
        <ModalContainer>
          <ModalHeader>
            <Text>{enterCode}</Text>
          </ModalHeader>
          <ModalBody>
            <Code visible={visible} />
          </ModalBody>
          <ModalFooter>
            <Button text={submitCode} onClick={onClickEnterRoom} />
          </ModalFooter>
        </ModalContainer>
      </Wrapper>
    </>
  );
};

export default Modal;
