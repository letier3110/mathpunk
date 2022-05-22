import React, { FC } from "react";
import { useNavigate } from "react-router-dom";

interface ContinueButtonProps {
  children?: React.ReactNode;
  onClick?: () => void;
}

const ContinueButton: FC<ContinueButtonProps> = ({
  children,
  onClick = () => {},
}) => {
  const navigate = useNavigate();

  const handleClick = () => {
    onClick();
    navigate(-1);
  };

  return (
    <div onClick={handleClick} className="continueButton">
      {children}
    </div>
  );
};

export default ContinueButton;
