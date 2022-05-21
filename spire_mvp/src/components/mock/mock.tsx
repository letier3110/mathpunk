import React, { FC } from "react";
import { NavigatorScreens } from "../navigator/navigator.enum";
import { MockScreenMap } from "./mock-screen.map";

interface MockProps {
  screen: NavigatorScreens;
}

const Mock: FC<MockProps> = ({ screen }) => {
  return (
    <div>
      <img className="temp" alt={screen} src={MockScreenMap[screen]} />
    </div>
  );
};

export default Mock;
