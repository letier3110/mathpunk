import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/classes/card/doubt.card.dart';
import 'package:mathpunk_cardgame/classes/card/normality.card.dart';
import 'package:mathpunk_cardgame/classes/deck.dart';
import 'package:mathpunk_cardgame/classes/game_map.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/room/event_room/mind_bloom.event.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';

class MindBloomView extends StatefulWidget {
  final MindBloomEventRoom room;

  const MindBloomView({required this.room, Key? key}) : super(key: key);

  @override
  State<MindBloomView> createState() => _MindBloomViewView();
}

class _MindBloomViewView extends State<MindBloomView> {
  bool canLeave = false;

  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    void warTapHandler() {
      // "[I am War] Fight a Boss from Act 1. Obtain a Rare Relic, normal rewards and 50 (25) gold.",
      gameState.changeCurrentRoom(generateBossRoom());
    }

    void richTapHandler() {
      // "[I am Rich] Gain 999 gold. Become Cursed - 2 Normalities.",
      gameState.givePlayerGold(999);
      Deck deck = Player.getPlayerInstance().getCharacter().getDeck();
      deck.addToDeck(NormalityCard());
      deck.addToDeck(NormalityCard());

      widget.room.setCanLeaveRoom(true);
      setState(() {
        canLeave = true;
      });
    }

    void onHealthyTap() {
      // "[I am Healthy] Heal to full HP. Become Cursed - Doubt.",
      gameState.healPlayer(HealPlayer.fullHeal, 0);
      Player.getPlayerInstance()
          .getCharacter()
          .getDeck()
          .addToDeck(DoubtCard());

      widget.room.setCanLeaveRoom(true);
      setState(() {
        canLeave = true;
      });
    }

    void onLeaveRoomTap() {
      gameState.enterMap();
    }

    double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: const Color(0xFF222222),
      child: Container(
        margin: const EdgeInsets.all(60),
        color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width / 3,
              height: width / 3,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 28, 10, 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/mind_bloom.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 28, 10, 10),
              width: (width / 2),
              height: width / 3,
              child: ListView(
                children: [
                  if (canLeave)
                    const Text('Can it really be this easy?',
                        style: TextStyle(color: Colors.black, fontSize: 24)),
                  if (!canLeave)
                    const Text(
                        'While walking and traversing through the chaos of the Spire, your thoughts suddenly begin to feel very... real...',
                        style: TextStyle(color: Colors.black, fontSize: 24)),
                  if (!canLeave)
                    RichText(
                        textAlign: TextAlign.left,
                        text: const TextSpan(children: [
                          TextSpan(
                              text: 'Imaginings of ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24)),
                          TextSpan(
                              text: 'monsters',
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 24)),
                          TextSpan(
                              text: ' and ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24)),
                          TextSpan(
                              text: 'riches ',
                              style: TextStyle(
                                  color: Colors.deepPurple, fontSize: 24)),
                          TextSpan(
                              text:
                                  'begin to manifest themselves into reality.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24)),
                        ])),
                  if (!canLeave)
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(12),
                            child: ElevatedButton(
                              onPressed: warTapHandler,
                              // style: ElevatedButton.styleFrom(
                              //     surfaceTintColor: Colors.greenAccent),
                              child: Container(
                                  padding: const EdgeInsets.all(12),
                                  width: (width - 200) / 2,
                                  child: const Text(
                                    "[I am War] Fight a Boss from Act 1. Obtain a Rare Relic, normal rewards and 50 (25) gold.",
                                    style: TextStyle(fontSize: 24),
                                  )),
                            )),
                      ],
                    ),
                  if (!canLeave)
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(12),
                            child: ElevatedButton(
                              onPressed: richTapHandler,
                              // style: ElevatedButton.styleFrom(
                              //     surfaceTintColor: Colors.greenAccent),
                              child: Container(
                                  padding: const EdgeInsets.all(12),
                                  width: (width - 200) / 2,
                                  child: const Text(
                                    "[I am Rich] Gain 999 gold. Become Cursed - 2 Normalities.",
                                    style: TextStyle(fontSize: 24),
                                  )),
                            )),
                      ],
                    ),
                  if (!canLeave)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: ElevatedButton(
                            onPressed: onHealthyTap,
                            // style: ElevatedButton.styleFrom(
                            //     surfaceTintColor: Colors.greenAccent),
                            child: Container(
                                padding: const EdgeInsets.all(12),
                                width: (width - 200) / 2,
                                child: const Text(
                                  "[I am Healthy] Heal to full HP. Become Cursed - Doubt.",
                                  style: TextStyle(fontSize: 24),
                                )),
                          ),
                        ),
                      ],
                    ),
                  if (canLeave)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: ElevatedButton(
                            onPressed: onLeaveRoomTap,
                            // style: ElevatedButton.styleFrom(
                            //     surfaceTintColor: Colors.greenAccent),
                            child: Container(
                                padding: const EdgeInsets.all(12),
                                width: (width - 200) / 2,
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(fontSize: 24),
                                )),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
