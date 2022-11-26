import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/in_deck.provider.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class DiscardPileView extends ConsumerStatefulWidget {
  const DiscardPileView({Key? key}) : super(key: key);

  @override
  ConsumerState<DiscardPileView> createState() => DiscardPileViewView();
}

class DiscardPileViewView extends ConsumerState<DiscardPileView> {
  @override
  Widget build(BuildContext context) {
    final inDeck = ref.watch(inDeckProvider);
    final discardPile = ref.watch(playerCharacterProvider
        .select((value) => value?.deck.discardPile ?? []));

    final discardPileLength = discardPile.length;

    void onTapHandler() {
      if (inDeck.isEmpty) {
        ref.read(inDeckProvider.notifier).enterDeck(cards: discardPile);
        return;
      }
      ref.read(inDeckProvider.notifier).exitDeck();
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
                AppLocalizations.of(context)!.discardText,
                textAlign: TextAlign.left,
                style: const TextStyle(
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
                    discardPileLength.toString(),
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
