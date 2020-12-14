import styled from 'styled-components';

interface Props {
  visible?: boolean;
}

export default {
  SideBarWrapper: styled.div<Props>`
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
    z-index: 99;
    transform: ${({ visible }) =>
      visible ? 'translateX(0)' : 'translateX(-100%)'};
    transition: transform 0.3s ease-in-out;

    @media (max-width: ${({ theme }) => theme.mediaSize}) {
      width: 85%;
    }
  `,
  SideBarHeader: styled.div`
    display: flex;
    align-items: center;
    width: 100%;
    height: 5rem;
    padding: 1.5rem;
    border-bottom: 1px solid white;
    svg {
      fill: ${(props) => props.theme.whiteColor};
    }
  `,
  HeaderText: styled.div`
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 5rem;
    width: 100%;
    margin-left: 3rem;
    padding-left: 0.5rem;
    font-weight: 500;
  `,
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
