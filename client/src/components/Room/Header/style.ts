import styled from 'styled-components';

export default {
  Wrapper: styled.div`
    position: fixed;
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 5rem;
    padding: 0 2rem;
    border-bottom: ${(props) => props.theme.boxBorder};
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
    margin-left: 1rem;
    width: 24px;
    height: 24px;
  `,
};
