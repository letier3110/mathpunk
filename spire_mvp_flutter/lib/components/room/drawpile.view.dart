import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';
import 'package:mathpunk_cardgame/utils/font.util.dart';

class DrawPileView extends StatefulWidget {
  const DrawPileView({Key? key}) : super(key: key);

  @override
  State<DrawPileView> createState() => DrawPileViewView();
}

class DrawPileViewView extends State<DrawPileView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var drawPileLength =
        (gameState.playerCharacter?.deck.drawPile ?? []).length;

    void onTapHandler() {
      if (gameState.inDeck.isEmpty) {
        gameState.enterDeck(
            cards: gameState.playerCharacter?.deck.drawPile ?? []);
        return;
      }
      gameState.exitDeck();
    }

    return Positioned(
      bottom: 20,
      left: 20,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 80,
            height: 80,
            color: Colors.black,
            child: const Center(
              child: Text(
                'Draw',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
              bottom: -12,
              right: -12,
              child: SizedBox(
                width: 40,
                height: 50,
                child: Center(
                  child: Text(
                    drawPileLength.toString(),
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
