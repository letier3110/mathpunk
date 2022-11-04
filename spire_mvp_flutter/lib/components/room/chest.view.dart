import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/reward.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/controllers/gamestate/gamestate.controller.dart';

const double hpBarHeight = 20;

class ChestView extends StatefulWidget {
  final Reward reward;
  const ChestView({required this.reward, Key? key}) : super(key: key);

  @override
  State<ChestView> createState() => ChestViewView();
}

class ChestViewView extends State<ChestView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

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
