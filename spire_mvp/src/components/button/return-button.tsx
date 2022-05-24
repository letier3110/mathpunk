import React, { FC } from 'react';
import { useNavigate } from 'react-router-dom';

import { emptyFn } from '../../utils/empty-fn';

interface ReturnButtonProps {
  children?: React.ReactNode;
  onClick?: () => void;
}

const ReturnButton: FC<ReturnButtonProps> = ({ children, onClick = emptyFn }) => {
  const navigate = useNavigate();

  const handleClick = () => {
    onClick();
    navigate(-1);
  };

  return (
    <div onClick={handleClick} className="returnButton">
      {children}
    </div>
  );
};

export default ReturnButton;
