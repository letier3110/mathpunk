import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class CharacterDeck extends ConsumerStatefulWidget {
  const CharacterDeck({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterDeck> createState() => CharacterDeckView();
}

class CharacterDeckView extends ConsumerState<CharacterDeck> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider);

    var deckLength = (gameState.playerCharacter?.deck.cards ?? []).length;

    void onTapHandler() {
      if (gameState.inDeck.isEmpty) {
        ref
            .read(gamestateProvider.notifier)
            .enterDeck(cards: gameState.playerCharacter?.deck.cards ?? []);
        return;
      }
      ref.read(gamestateProvider.notifier).exitDeck();
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
