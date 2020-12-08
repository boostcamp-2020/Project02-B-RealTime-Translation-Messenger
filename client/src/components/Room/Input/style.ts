import styled from 'styled-components';

export default {
  Wrapper: styled.div`
    bottom: 0;
    width: 100%;
    height: 20vh;
    background: ${(props) => props.theme.bgColor};
  `,
  InputWrapper: styled.div`
    display: flex;
    height: 6rem;
    margin: 0 2rem 1.5rem 2rem;
  `,
  InputContainer: styled.div`
    position: relative;
    flex: 1 0 0;
    width: 100%;
    height: 100%;
    background: #f7f7f7;
    border-radius: 20px;
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
  `,
  Input: styled.input`
    width: 100%;
    padding: 1rem 5rem 1rem 1rem;
    font-size: 16px;
  `,
  VoiceButton: styled.button`
    position: absolute;
    top: 50%;
    right: 0;
    width: 50px;
    height: 50px;
    margin-right: 1rem;
    background: ${(props) => props.theme.blueColor};
    border-radius: 50%;
    transform: translateY(-50%);
    svg {
      margin: 10px;
      fill: ${(props) => props.theme.whiteColor};
    }
  `,
  Margin: styled.div`
    flex: 0.02 0 0;
  `,
  Translation: styled.div`
    flex: 1 0 0;
    height: 100%;
    padding: 1rem;
    background: #f7f7f7;
    border-radius: ${(props) => props.theme.borderRadius};
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
    font-size: 16px;
  `,
};
