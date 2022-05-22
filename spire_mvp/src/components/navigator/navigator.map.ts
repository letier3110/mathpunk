import { NavigatorScreens } from "./navigator.enum";

export const NavigatorScreensMap: Record<NavigatorScreens, string> = {
  [NavigatorScreens.MainMenu]: "/",
  [NavigatorScreens.PatchNotes]: "/patch-notes",
  [NavigatorScreens.Settings]: "/settings",
  [NavigatorScreens.Compedium]: "/compedium",
  [NavigatorScreens.GameModeSelect]: "/gamemode",
  [NavigatorScreens.Statistics]: "/statistics",
  [NavigatorScreens.Run]: "/run",
  [NavigatorScreens.StandardRun]: "/run",
  [NavigatorScreens.DailyRun]: "/run",
  [NavigatorScreens.CustomRun]: "/run",
};
