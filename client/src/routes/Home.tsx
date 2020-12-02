import React, { useState } from 'react';
import styled from 'styled-components';
import UserProfile from '../components/UserProfile';
import Language from '../components/Language';
import Button from '../components/Button';
import Footer from '../components/Footer';
import { Theme } from '../styles/Theme';
import Modal from '../components/Modal';

const Wrapper = styled.div`
  display: flex;
  justify-content: center;
  align-self: center;
`;

const Container = styled.div`
  display: flex;
  width: 30%;
  min-width: 360px;
  padding: 4rem 0;
  flex-direction: column;
`;

const Home: React.FC = () => {
  const { greenColor } = Theme;
  const [visible, setVisible] = useState(false);
  const [code, setCode] = useState('');

  const onClickEnterRoom = () => {
    setVisible(true);
  };

  return (
    <Wrapper>
      <Container>
        <Modal
          visible={visible}
          setVisible={setVisible}
          code={code}
          setCode={setCode}
        />
        <UserProfile />
        <Language />
        <Button onClick={onClickEnterRoom} text="대화방 참여하기" />
        <Button text="방 만들기" color={greenColor} />
        <Footer />
      </Container>
    </Wrapper>
  );
};

export default Home;
