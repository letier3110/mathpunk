import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/playerCharacter.provider.dart';

class DiscardPileView extends ConsumerStatefulWidget {
  const DiscardPileView({Key? key}) : super(key: key);

  @override
  ConsumerState<DiscardPileView> createState() => DiscardPileViewView();
}

class DiscardPileViewView extends ConsumerState<DiscardPileView> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider);
    final gameStateNotifier = ref.watch(gamestateProvider.notifier);
    final playerCharacter = ref.watch(playerCharacterProvider);

    var discardPileLength = (playerCharacter?.deck.discardPile ?? []).length;

    void onTapHandler() {
      if (gameState.inDeck.isEmpty) {
        gameStateNotifier.enterDeck(
            cards: playerCharacter?.deck.discardPile ?? []);
        return;
      }
      gameStateNotifier.exitDeck();
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
