import styled from 'styled-components';

export default {
  SideBarWrapper: styled.div`
    position: fixed;
    top: 0;
    left: 0;
    width: 20%;
    height: 100vh;
    min-width: 280px;
    color: ${(props) => props.theme.whiteColor};
    background-color: ${(props) => props.theme.blueColor};
    border-top-right-radius: 24px;
    border-bottom-right-radius: 24px;
    font-size: 1.2rem;
    z-index: 2;
  `,
  SideBarHeader: styled.div`
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 5rem;
    padding: 1.5rem;
    svg {
      fill: ${(props) => props.theme.whiteColor};
    }
  `,
  HamburgerButton: styled.button``,
  UserList: styled.ul`
    width: 100%;
  `,
  UserInfo: styled.div`
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.5rem 1.5rem 0 1.5rem;
  `,
  Avatar: styled.img`
    width: 20%;
    background-color: ${(props) => props.theme.whiteColor};
    border-radius: 100%;
  `,
};
