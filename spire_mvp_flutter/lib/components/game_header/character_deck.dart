import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class CharacterDeck extends StatefulWidget {
  const CharacterDeck({Key? key}) : super(key: key);

  @override
  State<CharacterDeck> createState() => CharacterDeckView();
}

class CharacterDeckView extends State<CharacterDeck> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var deckLength = (gameState.playerCharacter?.deck.cards ?? []).length;

    void onTapHandler() {
      if (gameState.inDeck.isEmpty) {
        gameState.enterDeck(cards: gameState.playerCharacter?.deck.cards ?? []);
        return;
      }
      gameState.exitDeck();
    }

    return Positioned(
      top: 0,
      bottom: 0,
      right: 100,
      child: Stack(children: [
        GestureDetector(
          onTap: onTapHandler,
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 80,
            color: Colors.black,
            child: Center(
              child: Text(
                'Deck',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getFontSize(22),
                    fontWeight: FontWeight.w600),
              ),
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
                  deckLength.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getFontSize(22),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ))
      ]),
    );
  }
}
