import React, { FC, useState } from 'react';
import styled from 'styled-components';
import { useMutation } from '@apollo/client';
import { useHistory } from 'react-router-dom';
import Button from '@components/Button';
import { ENTER_ROOM } from '@queries/room.queires';
import { EnterRoomResponse, MutationEnterRoomArgs } from '@generated/types';
import { useUserState } from '@contexts/UserContext';
import { useLocalizationState } from '@contexts/LocalizationContext';
import { CREATE_SYSTEM_MESSAGE } from '@queries/messege.queries';
import encrypt from '@utils/encryption';
import floatToast from '@utils/toast';
import S from '@styles/toast';
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
  width: 400px;
  height: 350px;
  min-width: 250px;
  border-radius: ${(props) => props.theme.borderRadius};
  background-color: ${(props) => props.theme.blackColor};
  overflow: hidden;
  z-index: 2;

  @media (max-width: 400px) {
    width: 25vw;
  }
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
  const [pinValue, setPinValue] = useState('');
  const { nickname, avatar, lang } = useUserState();
  const { enterCode, submitCode } = useLocalizationState();

  const onClickOverlay = () => {
    if (setVisible) setVisible(!visible);
  };

  const [enterRoomMutation] = useMutation<
    { enterRoom: EnterRoomResponse },
    MutationEnterRoomArgs
  >(ENTER_ROOM, {
    variables: {
      nickname,
      lang,
      avatar,
      code: pinValue,
    },
  });

  const [createSystemMessageMutation] = useMutation(CREATE_SYSTEM_MESSAGE, {
    variables: { source: 'in' },
  });

  const onClickEnterRoom = async () => {
    try {
      const { data } = await enterRoomMutation();
      if (!data) return;

      const { roomId, userId } = data.enterRoom;
      localStorage.setItem('token', data.enterRoom.token);

      await createSystemMessageMutation();

      history.push({
        pathname: `/room/${encrypt(`${roomId}`)}`,
        state: {
          userId,
          roomId,
          code: pinValue,
          lang,
        },
      });
    } catch (e) {
      floatToast('.modal-toast');
    }
  };

  return (
    <S.ToastWrapper>
      <Overlay visible={visible} onClick={onClickOverlay} />
      <Wrapper visible={visible}>
        <ModalContainer>
          <ModalHeader>
            <Text>{enterCode}</Text>
          </ModalHeader>
          <ModalBody>
            <Code
              pinValue={pinValue}
              setPinValue={setPinValue}
              visible={visible}
            />
          </ModalBody>
          <ModalFooter>
            <Button text={submitCode} onClick={onClickEnterRoom} />
          </ModalFooter>
        </ModalContainer>
      </Wrapper>
      <S.Toast className="modal-toast" isTop>
        잘못된 방코드입니다!
      </S.Toast>
    </S.ToastWrapper>
  );
};

export default Modal;
