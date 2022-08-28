import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';
import 'package:spire_mvp_flutter/controllers/saves.controller.dart';
import 'package:spire_mvp_flutter/enums/screens.enum.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class PauseScreen extends StatefulWidget {
  const PauseScreen({Key? key}) : super(key: key);

  @override
  State<PauseScreen> createState() => _PauseScreenState();
}

class _PauseScreenState extends State<PauseScreen> {
  @override
  Widget build(BuildContext context) {
    SavesController saves =
        Provider.of<SavesController>(context, listen: false);

    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

    void onReturn() {
      gameState.exitPause();
    }

    void onAbortRun() {
      gameState.stopPlaying();
      saves.saveGame(gameState);
      navigation.changeScreen(ScreenEnum.mainMenu);
    }

    void onSaveExit() {
      gameState.exitPause();
      saves.saveGame(gameState);
      navigation.changeScreen(ScreenEnum.mainMenu);
      // TODO: persist state
      // exit(0)
    }

    return Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xEE000000),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Center(
            child: SizedBox(
              width: 500,
              height: 630,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: const Size(500, 630),
                      child: const Image(
                          image: AssetImage('assets/pause_bg.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(100, 92, 100, 92),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: onReturn,
                            child: Container(
                              width: 580,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/menu_bg_2.png'),
                                    fit: BoxFit.fill),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text('Return',
                                    style: TextStyle(
                                        fontSize: getFontSize(40),
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onAbortRun,
                            child: Container(
                              width: 580,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/menu_bg_2.png'),
                                    fit: BoxFit.fill),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text('Abandon Run',
                                    style: TextStyle(
                                        fontSize: getFontSize(40),
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onSaveExit,
                            child: Container(
                              width: 580,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/menu_bg_2.png'),
                                    fit: BoxFit.fill),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text('Save & quit',
                                    style: TextStyle(
                                        fontSize: getFontSize(40),
                                        color: Colors.white)),
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ))
    ]);
  }
}
