import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/reward.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class RewardView extends StatefulWidget {
  final Reward reward;
  const RewardView({required this.reward, Key? key}) : super(key: key);

  @override
  State<RewardView> createState() => RewardViewView();
}

class RewardViewView extends State<RewardView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    void onTapHandler() {
      // gameState.nextTurn();
    }

    int goldReward = widget.reward.gold ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: onTapHandler,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                if (widget.reward.gold != null)
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
        GestureDetector(
          onTap: onTapHandler,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Text(
                  'End Turn',
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
        GestureDetector(
          onTap: onTapHandler,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  'End Turn',
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
