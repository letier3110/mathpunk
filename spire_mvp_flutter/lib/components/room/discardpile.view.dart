import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class DiscardPileView extends StatefulWidget {
  const DiscardPileView({Key? key}) : super(key: key);

  @override
  State<DiscardPileView> createState() => DiscardPileViewView();
}

class DiscardPileViewView extends State<DiscardPileView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var discardPileLength =
        (gameState.playerCharacter?.deck.discardPile ?? []).length;

    void onTapHandler() {
      if (gameState.inDeck.isEmpty) {
        gameState.enterDeck(
            cards: gameState.playerCharacter?.deck.discardPile ?? []);
        return;
      }
      gameState.exitDeck();
    }

    return Positioned(
      bottom: 20,
      right: 20,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 100,
            height: 80,
            color: Colors.black,
            child: Center(
              child: Text(
                'Discard',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getFontSize(22),
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
                    discardPileLength.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getFontSize(22),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
