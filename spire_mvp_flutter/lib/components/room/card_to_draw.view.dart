import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_effects/select_card.card_effect.dart';
import 'package:mathpunk_cardgame/controllers/card_effect.provider.dart';
import 'package:mathpunk_cardgame/controllers/current_card.provider.dart';
import 'package:mathpunk_cardgame/controllers/current_card_effect.provider.dart';

import '../playable_card/playable_card.view.dart';

class CardToDraw extends ConsumerStatefulWidget {
  final List<PlayableCard> cards;
  final PlayableCard currentCard;
  const CardToDraw({Key? key, required this.cards, required this.currentCard})
      : super(key: key);

  @override
  ConsumerState<CardToDraw> createState() => CardToDrawView();
}

class CardToDrawView extends ConsumerState<CardToDraw> {
  List<PlayableCard> choice = [];

  @override
  Widget build(BuildContext context) {
    final cardEffect = ref.watch(currentCardProvider
        .select((value) => value!.effects[value.currentEffectId]));
    void onSubmitTapHandler() {
      if (cardEffect == null ||
          cardEffect.runtimeType != SelectCardCardEffect) {
        return;
      }
      // gameState.setSelectedCards(choice);
      // gameState.playTheCard(widget.currentCard, []);
      ref.read(cardEffectProvider.notifier).playTheEffect(card);
      // ref.read(currentCardEffectProvider)
      (cardEffect as SelectCardCardEffect).selectCard(choice);
      // ref.read(gamestateProvider.notifier).checkEnemies();
    }

    void onTapHandler(PlayableCard tapCard) {
      setState(() {
        if (choice.contains(tapCard)) {
          choice.remove(tapCard);
        } else if (choice.length < widget.currentCard.getMaxSelectableCards()) {
          choice.add(tapCard);
        }
      });
    }

    return Container(
      color: Colors.black38,
      child: Positioned(
        top: 0,
        left: 200,
        right: 200,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 400,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.cards
                  .map((e) => GestureDetector(
                        onTap: () {
                          onTapHandler(e);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: IgnorePointer(
                          ignoring: true,
                          ignoringSemantics: true,
                          child: PlayableCardComponent(
                            card: e,
                            animate: false,
                            glow: choice.contains(e) == false,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Positioned(
              bottom: 300,
              child: Center(
                child: GestureDetector(
                  onTap: onSubmitTapHandler,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(48, 16, 48, 16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(color: Colors.white, width: 2)
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.confirmText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
