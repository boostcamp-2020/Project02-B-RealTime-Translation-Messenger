import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { useHistory } from 'react-router-dom';
import { useMutation } from '@apollo/client';
import UserProfile from '@components/UserProfile';
import Button from '@components/Common/Button';
import Footer from '@components/Common/Footer';
import { Theme } from '@styles/Theme';
import Modal from '@components/Modal';
import { CreateRoomResponse, MutationCreateRoomArgs } from '@generated/types';
import { CREATE_ROOM } from '@queries/room.queires';
import { CREATE_SYSTEM_MESSAGE } from '@queries/messege.queries';
import { useUserState } from '@contexts/UserContext';
import encrypt from '@utils/encryption';
import client, { wsClient } from '@/apollo/Client';
import { getText } from '@/constants/localization';

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
  width: 30%;
  min-width: 360px;
  padding: 3rem;
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    padding: 0.5rem 3rem;
  }
`;

const Home: React.FC = () => {
  const history = useHistory();
  const { greenColor } = Theme;
  const { avatar, nickname, lang } = useUserState();
  const { createRoom, enterRoom } = getText(lang);
  const [visible, setVisible] = useState(false);
  const [isNicknameValid, setIsNicknameValid] = useState(true);

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
    if (!data) return;
    const { roomId, code, userId } = data.createRoom;
    localStorage.setItem('token', data?.createRoom.token);
    await createSystemMessageMutation();
    history.push({
      pathname: `/room/${encrypt(`${roomId}`)}`,
      state: {
        lang,
        code,
        userId,
        roomId,
      },
    });
  };

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token) {
      localStorage.removeItem('token');
      client.resetStore();
      wsClient.close();
    }
  }, []);

  return (
    <Wrapper>
      <Container>
        <Modal visible={visible} setVisible={setVisible} />
        <UserProfile
          isNicknameValid={isNicknameValid}
          setIsNicknameValid={setIsNicknameValid}
        />
        <Button
          onClick={onClickEnterRoom}
          text={enterRoom}
          isValid={isNicknameValid && nickname.length > 0}
        />
        <Button
          text={createRoom}
          color={greenColor}
          onClick={onClickCreateRoom}
          isValid={isNicknameValid && nickname.length > 0}
        />
        <Footer />
      </Container>
    </Wrapper>
  );
};

export default Home;
