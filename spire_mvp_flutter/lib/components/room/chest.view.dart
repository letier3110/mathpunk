import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/reward.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

const double hpBarHeight = 20;

class ChestView extends ConsumerStatefulWidget {
  final Reward reward;
  const ChestView({required this.reward, Key? key}) : super(key: key);

  @override
  ConsumerState<ChestView> createState() => ChestViewView();
}

class ChestViewView extends ConsumerState<ChestView> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider.notifier);

    void onTapHandler() {
      gameState.selectChest(widget.reward);
    }

    double width = MediaQuery.of(context).size.width;

    return Positioned(
      top: 200,
      right: width / 3,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: width / 6,
            width: width / 6,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/cards/chest.png'),
                  fit: BoxFit.cover),
            ),
          ),
        ]),
      ),
    );
  }
}
