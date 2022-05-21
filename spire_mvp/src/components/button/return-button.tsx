import React, { FC } from "react";
import { useNavigate } from "react-router-dom";
import { NavigatorScreensMap } from "../navigator/navigator.map";

interface ReturnButtonProps {
  children?: React.ReactNode;
  onClick?: () => void;
}

const ReturnButton: FC<ReturnButtonProps> = ({
  children,
  onClick = () => {},
}) => {
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
