import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/in_deck.provider.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class CharacterDeck extends ConsumerStatefulWidget {
  const CharacterDeck({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterDeck> createState() => CharacterDeckView();
}

class CharacterDeckView extends ConsumerState<CharacterDeck> {
  @override
  Widget build(BuildContext context) {
    final inDeck = ref.watch(inDeckProvider);
    final deckCards = ref.watch(
        playerCharacterProvider.select((value) => (value?.deck.cards ?? [])));

    void onTapHandler() {
      if (inDeck.isEmpty) {
        ref.read(inDeckProvider.notifier).enterDeck(cards: deckCards);
        return;
      }
      ref.read(inDeckProvider.notifier).exitDeck();
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
                  deckCards.length.toString(),
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
