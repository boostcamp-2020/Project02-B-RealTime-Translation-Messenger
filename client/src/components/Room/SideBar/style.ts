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
    z-index: 2;
    transform: ${({ visible }) =>
      visible ? 'translateX(0)' : 'translateX(-100%)'};
    transition: transform 0.3s ease-in-out;

    @media (max-width: ${({ theme }) => theme.mediaSize}) {
      width: 100%;
      border-radius: 0;
    }
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
  HeaderText: styled.div`
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 5rem;
    width: 100%;
    margin-left: 3rem;
    padding: 0.7rem 1rem 0rem 1rem;
    font-weight: 700;
  `,
  UserList: styled.ul`
    width: 100%;
    height: 85vh;
    overflow-x: hidden;
    overflow-y: scroll;

    &::-webkit-scrollbar {
      width: 10px;
      background-color: inherit;
    }

    &::-webkit-scrollbar-thumb {
      background-color: ${(props) => props.theme.whiteColor};
      background-clip: padding-box;
      border: 2px solid transparent;
      border-radius: 16px;
    }
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
