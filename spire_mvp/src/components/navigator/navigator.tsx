import React from "react";
import { Route, Routes } from "react-router-dom";
import Compedium from "../../screens/compedium";
import GameModeSelect from "../../screens/game-mode-select";

import MainMenu from "../../screens/main-menu";
import PatchNotes from "../../screens/patch-notes";
import Settings from "../../screens/settings";
import Statistics from "../../screens/statistics";
import { NavigatorScreensMap } from "./navigator.map";

function Navigator() {
  return (
    <Routes>
      <Route path={NavigatorScreensMap.MainMenu} element={<MainMenu />} />
      <Route path={NavigatorScreensMap.PatchNotes} element={<PatchNotes />} />
      <Route path={NavigatorScreensMap.Settings} element={<Settings />} />
      <Route
        path={NavigatorScreensMap.GameModeSelect}
        element={<GameModeSelect />}
      />
      <Route path={NavigatorScreensMap.Compedium} element={<Compedium />} />
      <Route path={NavigatorScreensMap.Statistics} element={<Statistics />} />
      {/* <Route path="expenses" element={<MainMenu />} />
      <Route path="invoices" element={<MainMenu />} /> */}
    </Routes>
  );
}

export default Navigator;
