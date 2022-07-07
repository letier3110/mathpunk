import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class PlayerPawnView extends StatefulWidget {
  const PlayerPawnView({Key? key}) : super(key: key);

  @override
  State<PlayerPawnView> createState() => PlayerPawnViewView();
}

class PlayerPawnViewView extends State<PlayerPawnView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var hp = gameState.playerCharacter?.health ?? '0';
    var maxhp = gameState.playerCharacter?.maxHealth ?? '0';
    bool isPlayerAlive = gameState.playerCharacter!.health > 0;

    void onTapHandler() {
      // TODO: implement drawpile tap handler
    }

    return Positioned(
      top: 100,
      left: 220,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 300,
            width: 300,
            color: Colors.black,
            child: const Center(
              child: Text(
                'Player',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          if (isPlayerAlive)
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(color: Colors.white, width: 2)
                  ),
                  child: Center(
                    child: Text(
                      '$hp / $maxhp',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ))
        ]),
      ),
    );
  }
}
