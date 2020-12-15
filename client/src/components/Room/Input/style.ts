import styled from 'styled-components';
import TextareaAutosize from 'react-autosize-textarea';

export default {
  Wrapper: styled.div`
    position: relative;
    bottom: 0;
    width: 100%;
    height: 20vh;
    background: ${(props) => props.theme.bgColor};
  `,
  InputWrapper: styled.div`
    display: flex;
    height: fit-content;
    margin: 0 2rem 1.5rem 2rem;
    @media (max-width: ${({ theme }) => theme.mediaSize}) {
      flex-direction: column;
      div {
        :first-child {
          order: 3;
        }
        :nth-child(2) {
          order: 1;
        }
        :nth-child(1) {
          order: 2;
          margin: 1rem 0;
        }
      }
    }
  `,
  InputContainer: styled.div`
    position: relative;
    flex: 1 0 0;
    width: 100%;
    min-width: 49%;
    min-height: 6rem;
    border-radius: ${({ theme }) => theme.borderRadius};
    overflow: hidden;
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
    @media (max-width: ${({ theme }) => theme.mediaSize}) {
      min-height: 4.5rem;
      max-height: 4.5rem;
      font-size: 12px;
    }
  `,
  Input: styled(TextareaAutosize)<any>`
    width: 100%;
    min-height: 6rem;
    max-height: 6rem;
    padding: 1rem 5rem 3rem 1rem;
    background: #f7f7f7;
    border: none;
    font-size: 16px;
    resize: none;
    overflow: auto;
    &:focus {
      outline: none;
    }
    ${(props) =>
      props.value.length >= 190
        ? 'animation: vibrate 2s cubic-bezier(0.36, 0.07, 0.19, 0.97);'
        : ''}
    @media (max-width: ${({ theme }) => theme.mediaSize}) {
      min-height: 4.5rem;
      max-height: 4.5rem;
      padding: 1rem 3.5rem 1rem 1rem;
      font-size: 12px;
    }
    @keyframes vibrate {
      0%,
      2%,
      4%,
      6%,
      8%,
      10%,
      12%,
      14%,
      16%,
      18% {
        transform: translate3d(-1px, 0, 0);
      }
      1%,
      3%,
      5%,
      7%,
      9%,
      11%,
      13%,
      15%,
      17%,
      19% {
        transform: translate3d(1px, 0, 0);
      }
      20%,
      100% {
        transform: translate3d(0, 0, 0);
      }
    }
  `,
  VoiceButton: styled.button`
    position: absolute;
    top: 50%;
    right: 0;
    margin-right: 1rem;
    transform: translateY(-50%);
    @media (max-width: ${({ theme }) => theme.mediaSize}) {
      height: 25px;
      width: 25px;
      transform: translate(-90%, -160%);
      svg {
        width: 20px;
        height: 20px;
      }
    }
  `,
  Margin: styled.div`
    flex: 0.02 0 0;
  `,
  Translation: styled(TextareaAutosize)<any>`
    flex: 1 0 0;
    width: 100%;
    min-width: 49%;
    min-height: 6rem;
    max-height: 6rem;
    padding: 1rem;
    color: ${(props) => props.theme.darkGrayColor};
    background: #f7f7f7;
    border: none;
    border-radius: ${(props) => props.theme.borderRadius};
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
    font-size: 16px;
    resize: none;
    overflow: auto;
    &:focus {
      outline: none;
    }
    @media (max-width: ${({ theme }) => theme.mediaSize}) {
      min-height: 4.5rem;
      max-height: 4.5rem;
      padding: 1rem 3.5rem 1rem 1rem;
      font-size: 12px;
    }
  `,
};
