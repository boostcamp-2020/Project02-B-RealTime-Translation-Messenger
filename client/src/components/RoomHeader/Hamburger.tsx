import React from 'react';
import styled from 'styled-components';

interface StyleProps {
  visible?: boolean;
}

const HamburgerWrapper = styled.div`
  width: 10rem;
`;
const HamburgerButton = styled.button<StyleProps>`
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  height: 1.5rem;
  padding: 0;
  background: transparent;
  z-index: 10;

  div {
    position: relative;
    width: 1.5rem;
    height: 0.1rem;
    background: ${({ theme, visible }) =>
      // eslint-disable-next-line no-nested-ternary
      visible
        ? theme.whiteColor
        : theme.isLight
        ? theme.blackColor
        : '#545759'};
    border-radius: 10px;
    transition: all 0.3s linear;
    transform-origin: 0.5px;
    z-index: 100;

    :nth-child(1) {
      transform: ${({ visible }) => (visible ? 'rotate(45deg)' : 'rotate(0)')};
    }
    :nth-child(2) {
      opacity: ${({ visible }) => (visible ? '0' : '1')};
      transform: ${({ visible }) =>
        visible ? 'translateX(20px)' : 'translateX(0)'};
    }
    :nth-child(3) {
      transform: ${({ visible }) => (visible ? 'rotate(-45deg)' : 'rotate(0)')};
    }
  }
`;

interface Props {
  visible: boolean;
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
}

const Hamburger: React.FC<Props> = ({ visible, setVisible }) => {
  const onClickHamburger = () => {
    setVisible(!visible);
  };

  return (
    <HamburgerWrapper>
      <HamburgerButton visible={visible} onClick={onClickHamburger}>
        <div />
        <div />
        <div />
      </HamburgerButton>
    </HamburgerWrapper>
  );
};

export default Hamburger;
