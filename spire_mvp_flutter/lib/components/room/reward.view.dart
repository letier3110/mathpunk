import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/reward.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class RewardView extends StatefulWidget {
  final Reward reward;
  final int rewardIndex;
  const RewardView({required this.reward, required this.rewardIndex, Key? key})
      : super(key: key);

  @override
  State<RewardView> createState() => RewardViewView();
}

class RewardViewView extends State<RewardView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.reward.gold != null)
          GestureDetector(
            onTap: onGoldTapHandler,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(
                    'gold.png ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getFontSize(16),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '$goldReward gold',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getFontSize(16),
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
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(
                    'Item',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getFontSize(16),
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
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(
                    widget.reward.relic!.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getFontSize(16),
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
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(
                    'Add card to your deck',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getFontSize(16),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
