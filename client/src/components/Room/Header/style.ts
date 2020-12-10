import styled from 'styled-components';

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
  HamburgerButton: styled.button`
    width: 24px;
    height: 24px;
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
