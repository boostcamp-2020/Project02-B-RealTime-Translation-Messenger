import React from 'react';
import styled from 'styled-components';
import UserProfile from '../components/UserProfile';
import Language from '../components/Language';
import Button from '../components/Button';
import Footer from '../components/Footer';
import { Theme } from '../styles/Theme';

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
  return (
    <Wrapper>
      <Container>
        <UserProfile />
        <Language />
        <Button text="대화방 참여하기" />
        <Button text="방 만들기" color={greenColor} />
        <Footer />
      </Container>
    </Wrapper>
  );
};

export default Home;
