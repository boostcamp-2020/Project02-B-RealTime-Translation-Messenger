import React, { FC } from 'react';
import styled from 'styled-components';

interface Props {
  text?: string;
  isTimeVisible?: boolean;
}

const Text = styled.div<Props>`
  display: ${(props) => (props.isTimeVisible ? 'inline-block' : 'none')};
  margin-right: 0.3rem;
  color: ${({ theme }) => theme.reverseColor};
`;

const TimeText: FC<Props> = ({ text, isTimeVisible }) => (
  <Text isTimeVisible={isTimeVisible}>{text}</Text>
);

export default TimeText;
