import styled, { css } from 'styled-components';

interface Props {
  visible?: boolean;
}

export default {
  Wrapper: styled.div`
    top: 0;
    right: 0;
    left: 0;
    display: flex;
    align-items: center;
    width: 100%;
    height: 5rem;
    padding: 0 2rem;
    background: ${({ theme }) => theme.whiteColor};
    border-bottom: ${({ theme }) => theme.boxBorder};
    z-index: 1;

    .reveal {
      opacity: 1;
      visibility: visible;
      transform: translate(-50%, 0);
    }

    ${({ theme }) =>
      !theme.isLight &&
      css`
        background: #373739;
        color: #e5e5e5;
        border: none;
      `};

    @media (max-width: ${({ theme }) => theme.mediaSize}) {
      padding: 0 1.5rem;
    }
  `,
  HamburgerWrapper: styled.div`
    width: 10rem;
  `,
  HamburgerButton: styled.button<Props>`
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
    margin: 0 auto;
    cursor: pointer;
    svg {
      fill: ${({ theme }) => (theme.isLight ? theme.blackColor : '#e5e5e5')};
    }
  `,
  Code: styled.div`
    margin-right: 0.3rem;
    font-size: 20px;
    font-weight: 500;
  `,
  RightWrapper: styled.div`
    display: flex;
    justify-content: flex-end;
    align-items: center;
    width: 10rem;
  `,
  DoorButton: styled.button`
    width: 24px;
    height: 24px;
    margin-left: 1rem;
    svg {
      fill: ${({ theme }) => (theme.isLight ? theme.blackColor : '#545759')};
    }
    @media (max-width: ${({ theme }) => theme.mediaSize}) {
      margin-left: 0.3rem;
    }
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
