import styled from 'styled-components';

export default {
  SideBarWrapper: styled.div`
    position: relative;
    width: 15%;
    min-width: 200px;
    height: 100vh;
    color: ${(props) => props.theme.whiteColor};
    background-color: ${(props) => props.theme.blueColor};
    border-bottom-right-radius: ${(props) => props.theme.borderRadius};
    border-top-right-radius: ${(props) => props.theme.borderRadius};
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
    padding: 1rem;
  `,
  Avatar: styled.img`
    width: 20%;
    border-radius: 100%;
    background-color: ${(props) => props.theme.whiteColor};
  `,
};
