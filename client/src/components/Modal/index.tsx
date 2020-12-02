import React, { FC } from 'react';
import styled from 'styled-components';
import Overlay from './Overlay';
import Code from './Code';
import Button from '../Button';

interface Props {
  visible: boolean;
}

const Wrapper = styled.div<Props>`
  position: fixed;
  top: 0;
  left: 50%;
  transform: translate(-50%, 10%);
  display: ${(props) => (props.visible ? 'block' : 'none')};
  display: flex;
  flex-direction: column;
  width: 20vw;
  height: inherit;
  min-width: 400px;
  min-height: 350px;
  border-radius: ${(props) => props.theme.borderRadius};
  background-color: ${(props) => props.theme.blackColor};
  overflow: hidden;
  z-index: 2;
`;

const ModalHeader = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  flex: 1 0 0;
  color: ${(props) => props.theme.whiteColor};
`;

const ModalBody = styled.div`
  margin-top: 1.5rem;
  flex: 2 0 0;
`;

const ModalFooter = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  flex: 1 0 0;
  margin-bottom: 1rem;
  padding: 0 20px;
`;

const Text = styled.div`
  font-size: 15px;
`;

const Modal: FC<Props> = ({ visible }) => {
  return (
    <>
      <Overlay visible={visible} />
      <Wrapper visible={visible}>
        <ModalHeader>
          <Text>참여 코드 6자리를 입력해주세요.</Text>
        </ModalHeader>
        <ModalBody>
          <Code />
        </ModalBody>
        <ModalFooter>
          <Button text="대화방 입장하기" />
        </ModalFooter>
      </Wrapper>
    </>
  );
};

export default Modal;
