import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/reward.dart';
import 'package:spire_mvp_flutter/components/room/reward.view.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

// View of rewards
class TraderView extends StatefulWidget {
  final List<Reward> rewards;
  const TraderView({required this.rewards, Key? key}) : super(key: key);

  @override
  State<TraderView> createState() => TraderViewView();
}

class TraderViewView extends State<TraderView> {
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
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
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
