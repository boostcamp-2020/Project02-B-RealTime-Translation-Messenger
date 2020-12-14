import React, { useState } from 'react';
import styled from 'styled-components';
import { useHistory } from 'react-router-dom';
import { useMutation } from '@apollo/client';
import UserProfile from '@components/UserProfile';
import Button from '@components/Button';
import Footer from '@components/Footer';
import { Theme } from '@styles/Theme';
import Modal from '@components/Modal';
import { CreateRoomResponse, MutationCreateRoomArgs } from '@generated/types';
import { CREATE_ROOM } from '@queries/room.queires';
import { CREATE_SYSTEM_MESSAGE } from '@queries/messege.queries';
import { useUserState } from '@contexts/UserContext';
import { useLocalizationState } from '@contexts/LocalizationContext';
import client from '@/apollo/Client';

const Wrapper = styled.div`
  min-width: inherit;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-self: center;
  overflow-x: hidden;
  overflow-y: scroll;
`;

const Container = styled.div`
  display: flex;
  flex-direction: column;
  width: 30%;
  min-width: 360px;
  padding: 3rem;
`;

const Home: React.FC = () => {
  const history = useHistory();
  const { createRoom, enterRoom } = useLocalizationState();
  const { greenColor } = Theme;
  const [visible, setVisible] = useState(false);
  const { avatar, nickname, lang } = useUserState();

  const onClickEnterRoom = () => {
    setVisible(true);
  };

  const [createRoomMutation] = useMutation<
    { createRoom: CreateRoomResponse },
    MutationCreateRoomArgs
  >(CREATE_ROOM, {
    variables: {
      nickname,
      lang,
      avatar,
    },
  });

  const [createSystemMessageMutation] = useMutation(CREATE_SYSTEM_MESSAGE, {
    variables: { source: 'in' },
  });

  const onClickCreateRoom = async () => {
    const { data } = await createRoomMutation();
    const roomId = data?.createRoom.roomId;
    const code = data?.createRoom.code;
    const userId = data?.createRoom.userId;
    if (typeof data?.createRoom.token === 'string')
      localStorage.setItem('token', data?.createRoom.token);
    await createSystemMessageMutation();
    history.push({
      pathname: `/room/${roomId}`,
      state: {
        lang,
        code,
        userId,
      },
    });
  };

  return (
    <Wrapper>
      <Container>
        <Modal visible={visible} setVisible={setVisible} />
        <UserProfile />
        <Button onClick={onClickEnterRoom} text={enterRoom} />
        <Button
          text={createRoom}
          color={greenColor}
          onClick={onClickCreateRoom}
        />
        <Footer />
      </Container>
    </Wrapper>
  );
};

export default Home;
