import React from "react";
import MainButton from "../components/button/main-button";
import ReturnButton from "../components/button/return-button";
import Mock from "../components/mock/mock";
import { NavigatorScreens } from "../components/navigator/navigator.enum";

function GameModeSelect() {
  return (
    <div>
      <Mock screen={NavigatorScreens.GameModeSelect} />
      <div>
        <div className="logo">Mathpunk spire</div>
        <ReturnButton>Return</ReturnButton>
      </div>
    </div>
  );
}

export default GameModeSelect;
