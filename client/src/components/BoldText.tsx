import React, { FC } from 'react';
import styled from 'styled-components';

interface Props {
  text: string;
}

const Text = styled.span`
  font-weight: 600;
`;

const FatText: FC<Props> = ({ text }) => <Text>{text}</Text>;

FatText.defaultProps = {
  text: '',
};

export default FatText;
