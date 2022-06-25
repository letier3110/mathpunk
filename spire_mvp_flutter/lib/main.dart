import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import './screens/main_menu.screen.dart';
import './controllers/navigation.controller.dart';
import './enums/screens.enum.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ListenableProvider<NavigationController>(
        create: (_) => NavigationController(),
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
      pageList.add(const MaterialPage(
          child: const MainMenuScreen(title: 'Mathpunk spire')));
      break;
    default:
      pageList.add(const MaterialPage(
          child: const MainMenuScreen(title: 'Mathpunk spire')));
      break;
  }
  return pageList;
}
