import mainMenuIcon from "../../assets/menu.png";
import patchNotesIcon from "../../assets/pathnotes.png";
import settingsIcon from "../../assets/game_settings.png";
import compediumIcon from "../../assets/compedium_select.png";
import gameModeSelectIcon from "../../assets/gamemode_select.png";
import statisticsIcon from "../../assets/statistics_select.png";

import { NavigatorScreens } from "../navigator/navigator.enum";

export const MockScreenMap: Record<NavigatorScreens, string> = {
  [NavigatorScreens.MainMenu]: mainMenuIcon,
  [NavigatorScreens.PatchNotes]: patchNotesIcon,
  [NavigatorScreens.Settings]: settingsIcon,
  [NavigatorScreens.Compedium]: compediumIcon,
  [NavigatorScreens.GameModeSelect]: gameModeSelectIcon,
  [NavigatorScreens.Statistics]: statisticsIcon,
};
