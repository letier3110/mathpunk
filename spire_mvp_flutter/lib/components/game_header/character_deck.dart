import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';

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
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/menu_bg_2.png'), fit: BoxFit.fill),
        ),
        child: Stack(children: [
          GestureDetector(
            onTap: onTapHandler,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 90,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.deckText,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 6,
              right: 6,
              child: SizedBox(
                width: 70,
                height: 21,
                child: Text(
                  deckLength.toString(),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ))
        ]),
      ),
    );
  }
}
