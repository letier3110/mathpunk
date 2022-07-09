import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:spire_mvp_flutter/classes/card/cards_implementation.dart';
// import 'package:spire_mvp_flutter/components/playable_card/playable_card.view.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

import '../components/main_menu_item.dart';
import '../enums/screens.enum.dart';
import '../utils/font.util.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

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
              'Mathpunk spire',
              style: TextStyle(fontSize: getFontSize(34)),
            ),
          )),
          // Positioned(
          //     top: 120,
          //     right: 120,
          //     child: PlayableCardComponent(
          //       card: strikeCard,
          //     )),
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
                      child: Column(children: [
                        Consumer<GamestateController>(
                            builder: (gameStateContext, gameStateState, child) {
                          if (gameStateState.gameMap.isNotEmpty) {
                            return const MainMenuItem(
                              text: 'Continue Run',
                              screen: ScreenEnum.game,
                            );
                          }
                          return const MainMenuItem(
                            text: 'Play',
                            screen: ScreenEnum.modeSelect,
                          );
                        }),
                        const MainMenuItem(
                          text: 'Compedium',
                          screen: ScreenEnum.compedium,
                        ),
                        const MainMenuItem(
                          text: 'Statistics',
                          screen: ScreenEnum.statistics,
                        ),
                        const MainMenuItem(
                          text: 'Settings',
                          screen: ScreenEnum.settings,
                        ),
                        const MainMenuItem(
                          text: 'Patch Notes',
                          screen: ScreenEnum.patchNotes,
                        ),
                        const MainMenuItem(
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
