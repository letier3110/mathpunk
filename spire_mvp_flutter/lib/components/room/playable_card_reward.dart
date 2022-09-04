import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';

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
              Center(
                  child: Container(
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 92),
                height: 200,
                width: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.card.asset),
                      fit: BoxFit.fitWidth),
                ),
              )),
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/card_front_full.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 300,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.card.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              height: 110,
                              child: Column(
                                children: [widget.card.getCardDescription()],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 190 / 24,
                        child: Container(
                          width: 24,
                          height: 24,
                          // padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: const Color(0xFFC99C66),
                              borderRadius: BorderRadius.circular(24),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
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
