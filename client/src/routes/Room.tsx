import React from 'react';
import { useLocation } from 'react-router-dom';
import RoomComponent from '@components/Room';

const Room: React.FC = () => {
  const location: any = useLocation();
  const { userId, code, nickname, avatar, lang } = location.state;
  return (
    <>
      <RoomComponent />
      <h1>Room</h1>
      <p>{userId}</p>
      <p>{code}</p>
      <p>{nickname}</p>
      <p>{avatar}</p>
      <p>{lang}</p>
    </>
  );
};

export default Room;
