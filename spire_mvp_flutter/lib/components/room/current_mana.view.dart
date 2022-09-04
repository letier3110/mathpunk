import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';

class CurrentManaView extends StatefulWidget {
  const CurrentManaView({Key? key}) : super(key: key);

  @override
  State<CurrentManaView> createState() => CurrentManaViewView();
}

class CurrentManaViewView extends State<CurrentManaView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var mana = gameState.playerCharacter?.mana ?? '0';

    void onTapHandler() {
      // TODO: implement drawpile tap handler
    }

    return Positioned(
      bottom: 120,
      left: 20,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(color: Colors.white, width: 2)
            ),
            child: Center(
              child: Text(
                mana.toString(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
