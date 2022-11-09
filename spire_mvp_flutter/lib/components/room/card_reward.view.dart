import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/components/room/playable_card_reward.dart';
// import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class CardReward extends ConsumerStatefulWidget {
  final List<PlayableCard> cards;
  const CardReward({required this.cards, Key? key}) : super(key: key);

  @override
  ConsumerState<CardReward> createState() => CardRewardView();
}

class CardRewardView extends ConsumerState<CardReward> {
  @override
  Widget build(BuildContext context) {
    // final gameState = ref.read(gamestateProvider.notifier);

    // void onSkipTapHandler() {
    //   gameState.stopSelectingCardReward();
    // }

    return Center(
      child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 32),
                child: Text(
                  AppLocalizations.of(context)!.chooseACardRewardText,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.cards
                    .map((e) => PlayableCardReward(
                        possibleRewards: widget.cards, card: e))
                    .toList(),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 32),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  AppLocalizations.of(context)!.chooseACardRewardText,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}
