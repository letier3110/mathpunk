import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/controllers/settings.provider.dart';
import 'package:mathpunk_cardgame/enums/supported_locale.enum.dart';
import 'package:mathpunk_cardgame/screens/audio.screen.dart';

import 'package:mathpunk_cardgame/screens/character_select/character_select.screen.dart';
import 'package:mathpunk_cardgame/screens/game.screen.dart';
import 'package:mathpunk_cardgame/screens/main_loading.screen.dart';
import 'package:mathpunk_cardgame/screens/mode_select.screen.dart';
import 'package:mathpunk_cardgame/screens/settings/settings.screen.dart';
import 'package:mathpunk_cardgame/screens/settings/settings.util.dart';
import 'package:window_size/window_size.dart';

import './screens/main_menu.screen.dart';
import 'controllers/navigation.provider.dart';
import './enums/screens.enum.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) {
      setWindowTitle("Mathpunk: card game");
    }

    final selectedLocale =
        ref.watch(settingsProvider.select((value) => value.selectedLocale));

    return MaterialApp(
        title: 'Mathpunk: card game',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        locale: getLocaleFromSupportedLocaleEnum(selectedLocale),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Stack(
          children: [
            const AudioScreen(),
            Navigator(
              pages: getPages(context, ref),
              onPopPage: (route, result) {
                return route.didPop(result);
              },
            ),
          ],
        ));
  }
}

List<Page> getPages(context, WidgetRef ref) {
  final ScreenEnum navigationScreen = ref.watch(navigationProvider);

  List<Page> pageList = [];

  switch (navigationScreen) {
    case ScreenEnum.mainMenu:
      pageList.add(const MaterialPage(child: MainMenuScreen()));
      break;
    case ScreenEnum.mainLoading:
      pageList.add(const MaterialPage(child: MainLoadingScreen()));
      break;
    case ScreenEnum.modeSelect:
      pageList.add(const MaterialPage(child: ModeSelectScreen()));
      break;
    case ScreenEnum.characterSelect:
      pageList.add(const MaterialPage(child: CharacterSelect()));
      break;
    case ScreenEnum.settings:
      pageList.add(const MaterialPage(child: SettingsScreen()));
      break;
    case ScreenEnum.game:
      pageList.add(const MaterialPage(child: GameScreen()));
      break;
    default:
      pageList.add(const MaterialPage(child: MainMenuScreen()));
      break;
  }
  return pageList;
}
