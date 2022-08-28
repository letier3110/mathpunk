import compediumIcon from '../../assets/compedium_select.png';
import settingsIcon from '../../assets/game_settings.png';
import gameModeSelectIcon from '../../assets/gamemode_select.png';
import mainMenuIcon from '../../assets/menu.png';
import patchNotesIcon from '../../assets/pathnotes.png';
import standardRunIcon from '../../assets/standart_select.png';
import warriorStandardRunIcon from '../../assets/standart_select_ironclad.png';
import statisticsIcon from '../../assets/statistics_select.png';
import { NavigatorScreens } from '../navigator/navigator.enum';

export const MockScreenMap: Record<NavigatorScreens, string> = {
  [NavigatorScreens.MainMenu]: mainMenuIcon,
  [NavigatorScreens.PatchNotes]: patchNotesIcon,
  [NavigatorScreens.Settings]: settingsIcon,
  [NavigatorScreens.Compedium]: compediumIcon,
  [NavigatorScreens.GameModeSelect]: gameModeSelectIcon,
  [NavigatorScreens.Statistics]: statisticsIcon,
  [NavigatorScreens.Run]: warriorStandardRunIcon,
  [NavigatorScreens.StandardRun]: standardRunIcon,
  [NavigatorScreens.DailyRun]: standardRunIcon,
  [NavigatorScreens.CustomRun]: standardRunIcon
};
