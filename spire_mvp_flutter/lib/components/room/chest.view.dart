import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/classes/reward.dart';
import 'package:mathpunk_cardgame/components/room/reward.view.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';
import 'package:mathpunk_cardgame/utils/font.util.dart';

class ChestView extends StatefulWidget {
  final List<Reward> rewards;
  const ChestView({required this.rewards, Key? key}) : super(key: key);

  @override
  State<ChestView> createState() => ChestViewView();
}

class ChestViewView extends State<ChestView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    void onTapHandler() {
      // gameState.nextTurn();
    }

    int goldReward = widget.rewards
            .reduce((value, element) =>
                Reward(rewardGold: (value.gold ?? 0) + (element.gold ?? 0)))
            .gold ??
        0;

    return Center(
      child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pause_bg.png'), fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.rewards
                    .asMap()
                    .entries
                    .map((entry) =>
                        RewardView(rewardIndex: entry.key, reward: entry.value))
                    .toList(),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
