import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/reward.dart';
import 'package:mathpunk_cardgame/components/room/playable_card_reward.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';
import 'package:mathpunk_cardgame/utils/font.util.dart';

class CardReward extends StatefulWidget {
  final List<PlayableCard> cards;
  const CardReward({required this.cards, Key? key}) : super(key: key);

  @override
  State<CardReward> createState() => CardRewardView();
}

class CardRewardView extends State<CardReward> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    void onSkipTapHandler() {
      gameState.stopSelectingCardReward();
    }

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
                  'Choose a card',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getFontSize(22),
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
                  'Choose a card',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getFontSize(22),
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
