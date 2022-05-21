import React from "react";
import MainButton from "../components/button/main-button";
import Mock from "../components/mock/mock";
import { NavigatorScreens } from "../components/navigator/navigator.enum";

function MainMenu() {
  return (
    <div>
      <Mock screen={NavigatorScreens.MainMenu} />
      <div>
        <div className="logo">Mathpunk spire</div>
        <div className="mainButtons">
          <MainButton link={NavigatorScreens.GameModeSelect}>Play</MainButton>
          <MainButton link={NavigatorScreens.Compedium}>Compedium</MainButton>
          <MainButton link={NavigatorScreens.Statistics}>Statistics</MainButton>
          <MainButton link={NavigatorScreens.Settings}>Settings</MainButton>
          <MainButton link={NavigatorScreens.PatchNotes}>
            Patch Notes
          </MainButton>
          <MainButton>Quit</MainButton>
        </div>
      </div>
    </div>
  );
}

export default MainMenu;
