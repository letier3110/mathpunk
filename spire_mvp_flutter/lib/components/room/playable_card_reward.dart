import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class PlayableCardReward extends StatefulWidget {
  final PlayableCard card;
  final List<PlayableCard> possibleRewards;
  const PlayableCardReward(
      {required this.possibleRewards, required this.card, Key? key})
      : super(key: key);

  @override
  State<PlayableCardReward> createState() => PlayableCardRewardView();
}

class PlayableCardRewardView extends State<PlayableCardReward> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    void onTapHandler() {
      gameState.pickCardReward(widget.possibleRewards, widget.card);
    }

    return GestureDetector(
      onTap: onTapHandler,
      child: MouseRegion(
        child: Container(
          height: 308,
          width: 208,
          margin: const EdgeInsets.all(4),
          child: Center(
            child: Stack(children: [
              Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(8),
                height: 304,
                width: 204,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // margin: const EdgeInsets.all(4),
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 400,
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: Text(
                                widget.card.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getFontSize(22)),
                              ),
                            ),
                            SizedBox(
                              height: 160,
                              child: Column(
                                children: [widget.card.getCardDescription()],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          // padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: widget.card.getCardMana()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
