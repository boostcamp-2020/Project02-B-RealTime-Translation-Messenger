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
import { useUserState } from '@contexts/UserContext';
import { useLocalizationState } from '@/contexts/LocalizationContext';

const Wrapper = styled.div`
  display: flex;
  justify-content: center;
  align-self: center;
`;

const Container = styled.div`
  display: flex;
  width: 30%;
  min-width: 360px;
  padding: 3rem;
  flex-direction: column;
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

  const onClickCreateRoom = async () => {
    const { data } = await createRoomMutation();
    const roomId = data?.createRoom.roomId;
    const code = data?.createRoom.code;
    const userId = data?.createRoom.userId;
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
