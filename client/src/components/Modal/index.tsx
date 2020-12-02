import React, { FC } from 'react';
import styled from 'styled-components';
import Overlay from './Overlay';
import Code from './Code';

interface Props {
  visible: boolean;
}

const Wrapper = styled.div<Props>`
  display: ${(props) => (props.visible ? 'block' : 'none')};
  width: 20vw;
  min-width: 400px;
  min-height: 350px;
  border-radius: ${(props) => props.theme.borderRadius};
  background-color: ${(props) => props.theme.blackColor};
  overflow: hidden;
  z-index: 2;
`;

const ModalHeader = styled.div`
  height: 25%;
`;

const ModalBody = styled.div`
  height: 40%;
`;

const ModalFooter = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  height: 35%;
  padding: 0 10px;
  color: white;
`;

// 이후 Button Component로 대체 할 예정 임시 버튼
const Button = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 50px;
  border-radius: ${(props) => props.theme.borderRadius};
  background-color: ${(props) => props.theme.blueColor};
`;

const Modal: FC<Props> = ({ visible }) => {
  return (
    <>
      <Overlay visible={visible} />
      <Wrapper visible={visible}>
        <ModalHeader />
        <ModalBody>
          <Code />
        </ModalBody>
        <ModalFooter>
          <Button>Button</Button>
        </ModalFooter>
      </Wrapper>
    </>
  );
};

export default Modal;
