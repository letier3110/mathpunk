import React, { FC } from "react";
import { Link, useNavigate } from "react-router-dom";
import { NavigatorScreens } from "../navigator/navigator.enum";
import { NavigatorScreensMap } from "../navigator/navigator.map";

interface MainButtonProps {
  children?: React.ReactNode;
  link?: NavigatorScreens;
  onClick?: () => void;
}

const MainButton: FC<MainButtonProps> = ({
  children,
  onClick = () => {},
  link,
}) => {
  const navigate = useNavigate();

  const handleClick = () => {
    onClick();
    if (link) navigate(NavigatorScreensMap[link]);
  };

  return (
    <div onClick={handleClick} className="mainButton">
      {children}
    </div>
  );
};

export default MainButton;
