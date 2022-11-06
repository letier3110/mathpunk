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
  bool _hovered = false;

  void onEnterHandler(PointerEnterEvent p) {
    setState(() {
      _hovered = true;
    });
  }

  void onExitHandler(PointerExitEvent p) {
    setState(() {
      _hovered = false;
    });
  }

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
      child: MouseRegion(
        onEnter: onEnterHandler,
        onExit: onExitHandler,
        child: Container(
          decoration: _hovered
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 20.0,
                      spreadRadius: 0.0,
                    )
                  ],
                )
              : const BoxDecoration(),
          child: Stack(children: [
            GestureDetector(
              onTap: onTapHandler,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 90,
                color: Colors.black,
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
                bottom: -12,
                right: -12,
                child: SizedBox(
                  width: 40,
                  height: 50,
                  child: Center(
                    child: Text(
                      deckLength.toString(),
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
      ),
    );
  }
}
