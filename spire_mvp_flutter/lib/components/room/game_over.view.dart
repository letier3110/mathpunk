import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';
import 'package:mathpunk_cardgame/controllers/navigation.controller.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';
import 'package:mathpunk_cardgame/utils/font.util.dart';

class GameOver extends StatefulWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  State<GameOver> createState() => GameOverView();
}

class GameOverView extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

    void onTapHandler() {
      gameState.stopPlaying();
      navigation.changeScreen(ScreenEnum.mainMenu);
    }

    return Positioned(
      top: 0,
      left: 200,
      right: 200,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 100,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 400),
          child: Center(
            child: Text(
              'Death...',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getFontSize(22),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            child: GestureDetector(
                onTap: onTapHandler,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(48, 16, 48, 16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(color: Colors.white, width: 2)
                    ),
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getFontSize(22),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )))
      ]),
    );
  }
}
