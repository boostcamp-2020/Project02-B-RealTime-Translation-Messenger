import styled from 'styled-components';

export default {
  Wrapper: styled.div`
    position: absolute;
    bottom: 0;
    width: 100%;
  `,
  InputWrapper: styled.div`
    display: flex;
    margin: 0 2rem 1.5rem 2rem;
    height: 6rem;
  `,
  InputContainer: styled.div`
    position: relative;
    flex: 1 0 0;
    width: 100%;
    height: 100%;
    background: #f7f7f7;
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
    border-radius: 20px;
  `,
  Input: styled.input`
    width: 100%;
    padding: 1rem 5rem 1rem 1rem;
    font-size: 16px;
  `,
  VoiceButton: styled.button`
    position: absolute;
    margin-right: 1rem;
    width: 50px;
    height: 50px;
    top: 50%;
    transform: translateY(-50%);
    background: ${(props) => props.theme.blueColor};
    border-radius: 50%;
    right: 0;
    svg {
      margin: 10px;
      fill: ${(props) => props.theme.whiteColor};
    }
  `,
  Margin: styled.div`
    flex: 0.02 0 0;
  `,
  Translation: styled.div`
    height: 100%;
    padding: 1rem;
    font-size: 16px;
    flex: 1 0 0;
    background: #f7f7f7;
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
    border-radius: ${(props) => props.theme.borderRadius};
  `,
};
