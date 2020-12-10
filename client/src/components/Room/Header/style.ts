import styled from 'styled-components';

interface Props {
  visible?: boolean;
}

export default {
  Wrapper: styled.div`
    top: 0;
    right: 0;
    left: 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 10vh;
    padding: 0 2rem;
    background: ${(props) => props.theme.bgColor};
    border-bottom: ${(props) => props.theme.boxBorder};
    z-index: 1;
    .reveal {
      opacity: 1;
      visibility: visible;
      transform: translate(-50%, 0);
    }
  `,
  HamburgerButton: styled.button<Props>`
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    width: 2rem;
    height: 2rem;
    padding: 0;
    background: transparent;
    z-index: 10;

    div {
      position: relative;
      width: 2rem;
      height: 0.25rem;
      background: ${({ theme, visible }) =>
        visible ? theme.whiteColor : theme.blackColor};
      border-radius: 10px;
      transition: all 0.3s linear;
      transform-origin: 1px;

      :first-child {
        transform: ${({ visible }) =>
          visible ? 'rotate(45deg)' : 'rotate(0)'};
      }

      :nth-child(2) {
        opacity: ${({ visible }) => (visible ? '0' : '1')};
        transform: ${({ visible }) =>
          visible ? 'translateX(20px)' : 'translateX(0)'};
      }

      :nth-child(3) {
        transform: ${({ visible }) =>
          visible ? 'rotate(-45deg)' : 'rotate(0)'};
      }
    }
  `,
  CodeWrapper: styled.div`
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 0 auto !important;
    cursor: pointer;
  `,
  Code: styled.div`
    margin-right: 0.3rem;
    font-size: 20px;
    font-weight: bold;
  `,
  RightWrapper: styled.div`
    display: flex;
    justify-content: center;
    align-items: center;
  `,
  DoorButton: styled.button`
    width: 24px;
    height: 24px;
    margin-left: 1rem;
  `,
  Toast: styled.div`
    position: fixed;
    top: 5.5rem;
    left: 50%;
    padding: 1rem 1.5rem;
    color: #fff;
    background: rgba(0, 0, 0, 0.5);
    border-radius: 30px;
    font-size: 0.8rem;
    transform: translate(-50%, 10px);
    transition: opacity 0.5s, visibility 0.5s, transform 0.5s;
    opacity: 0;
    visibility: hidden;
    z-index: 10000;
  `,
};
