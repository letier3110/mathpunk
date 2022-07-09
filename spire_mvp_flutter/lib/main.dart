import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/controllers/saves.controller.dart';
import 'package:spire_mvp_flutter/screens/character_select.screen.dart';
import 'package:spire_mvp_flutter/screens/game.screen.dart';
import 'package:spire_mvp_flutter/screens/main_loading.screen.dart';
import 'package:spire_mvp_flutter/screens/mode_select.screen.dart';
import 'package:window_size/window_size.dart';

import './screens/main_menu.screen.dart';
import './controllers/navigation.controller.dart';
import './enums/screens.enum.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ListenableProvider<NavigationController>(
        create: (_) => NavigationController(),
      ),
      ListenableProvider<SavesController>(
        create: (_) => SavesController(),
      ),
      ListenableProvider<GamestateController>(
        create: (_) => GamestateController(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) {
      setWindowTitle("Mathpunk spire");
    }
    return MaterialApp(
      title: 'Mathpunk spire demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigator(
        pages: getPages(context),
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      ),
    );
  }
}

List<Page> getPages(context) {
  NavigationController navigation = Provider.of<NavigationController>(context);

  List<Page> pageList = [];

  switch (navigation.screen) {
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
    case ScreenEnum.game:
      pageList.add(const MaterialPage(child: GameScreen()));
      break;
    default:
      pageList.add(const MaterialPage(child: MainMenuScreen()));
      break;
  }
  return pageList;
}
