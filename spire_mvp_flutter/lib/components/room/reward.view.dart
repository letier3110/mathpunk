import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/reward.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class RewardView extends ConsumerStatefulWidget {
  final Reward reward;
  final int rewardIndex;
  const RewardView({required this.reward, required this.rewardIndex, Key? key})
      : super(key: key);

  @override
  ConsumerState<RewardView> createState() => RewardViewView();
}

class RewardViewView extends ConsumerState<RewardView> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider.notifier);

    void onGoldTapHandler() {
      gameState.pickReward(widget.rewardIndex, 'gold');
    }

    void onItemTapHandler() {
      gameState.pickReward(widget.rewardIndex, 'item');
    }

    void onRelicTapHandler() {
      gameState.pickReward(widget.rewardIndex, 'relic');
    }

    void onCardTapHandler() {
      gameState.selectCardReward(widget.reward.cards);
    }

    int goldReward = widget.reward.gold ?? 0;

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.reward.gold != null)
            GestureDetector(
              onTap: onGoldTapHandler,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/menu_bg_2.png'),
                      fit: BoxFit.fill),
                ),
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                height: 80,
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    // const Text(
                    //   'gold.png ',
                    //   textAlign: TextAlign.left,
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w600),
                    // ),
                    Text(
                      AppLocalizations.of(context)!
                          .rewardGoldText(goldReward.toString()),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.reward.item != null)
            GestureDetector(
              onTap: onItemTapHandler,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/menu_bg_2.png'),
                      fit: BoxFit.fill),
                ),
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                height: 80,
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Text(
                      widget.reward.item!.getItemName(context),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.reward.relic != null)
            GestureDetector(
              onTap: onRelicTapHandler,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/menu_bg_2.png'),
                      fit: BoxFit.fill),
                ),
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                height: 80,
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Text(
                      widget.reward.relic!.getNameTranslationKey(context),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.reward.cards.isNotEmpty)
            GestureDetector(
              onTap: onCardTapHandler,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/menu_bg_2.png'),
                      fit: BoxFit.fill),
                ),
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                height: 80,
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.rewardCardText,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
