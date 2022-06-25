import 'package:flutter/material.dart';

import '../components/main_menu_item.dart';
import '../enums/screens.enum.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Center(
              child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 160.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline4,
            ),
          )),
          Positioned(
            bottom: 0,
            child: Container(
                margin: const EdgeInsets.all(8.0),
                height: 500,
                alignment: Alignment.bottomLeft,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 120,
                      child: Column(children: const [
                        MainMenuItem(
                          text: 'Play',
                          screen: ScreenEnum.modeSelect,
                        ),
                        MainMenuItem(
                          text: 'Compedium',
                          screen: ScreenEnum.compedium,
                        ),
                        MainMenuItem(
                          text: 'Statistics',
                          screen: ScreenEnum.statistics,
                        ),
                        MainMenuItem(
                          text: 'Settings',
                          screen: ScreenEnum.settings,
                        ),
                        MainMenuItem(
                          text: 'Patch Notes',
                          screen: ScreenEnum.patchNotes,
                        ),
                        MainMenuItem(
                          text: 'Quit',
                          screen: ScreenEnum.quit,
                        ),
                      ]),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
