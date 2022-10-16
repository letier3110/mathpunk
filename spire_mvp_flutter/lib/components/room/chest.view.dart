import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/classes/reward.dart';
import 'package:mathpunk_cardgame/components/room/reward.view.dart';

class ChestView extends StatefulWidget {
  final Reward reward;
  final int rewardIndex;
  const ChestView({required this.reward, required this.rewardIndex, Key? key})
      : super(key: key);

  @override
  State<ChestView> createState() => ChestViewView();
}

class ChestViewView extends State<ChestView> {
  @override
  Widget build(BuildContext context) {
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
                      image: AssetImage('assets/pause_bg.png'),
                      fit: BoxFit.fill),
                ),
                child: RewardView(
                    rewardIndex: widget.rewardIndex, reward: widget.reward)),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
