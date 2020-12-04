import React, { useState } from 'react';
import RoomHeader from './Header';
import SideBar from './SideBar';

const Room: React.FC = () => {
  const [visible, setVisible] = useState<boolean>(true);

  return (
    <>
      <RoomHeader visible={visible} setVisible={setVisible} />
      <SideBar visible={visible} setVisible={setVisible} />
    </>
  );
};

export default Room;
