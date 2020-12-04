import React from 'react';
import styled from 'styled-components';

const FooterWrapper = styled.footer`
  margin: 0 auto;
  display: relative;
  transform: translateY(300%);
  color: ${(props) => props.theme.text};
  text-align: center;
  font-size: 1.2rem;
  strong {
    font-weight: bold;
  }
`;

const Footer: React.FC = () => {
  return (
    <FooterWrapper>
      Powered by
      <strong> papago</strong>
    </FooterWrapper>
  );
};

export default Footer;
