import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/card/doubt.card.dart';
import 'package:spire_mvp_flutter/classes/card/normality.card.dart';
import 'package:spire_mvp_flutter/classes/deck.dart';
import 'package:spire_mvp_flutter/classes/game_map.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/room/event_room/mind_bloom.event.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/character.util.dart';

import 'package:spire_mvp_flutter/utils/font.util.dart';

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

    return Container(
        margin: const EdgeInsets.all(60),
        color: Colors.amber,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 28, 10, 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(getCharacterAssetByName(
                              Player.getPlayerInstance().getCharacter())),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 28, 10, 10),
                    child: Column(
                      children: [
                        if (this.canLeave)
                          Text('Can it really be this easy?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(24))),
                        if (!this.canLeave)
                          Text(
                              'While walking and traversing through the chaos of the Spire, your thoughts suddenly begin to feel very... real...',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(24))),
                        if (!this.canLeave)
                          RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Imaginings of ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: getFontSize(24))),
                                TextSpan(
                                    text: 'monsters',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: getFontSize(24))),
                                TextSpan(
                                    text: ' and ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: getFontSize(24))),
                                TextSpan(
                                    text: 'riches ',
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: getFontSize(24))),
                                TextSpan(
                                    text:
                                        'begin to manifest themselves into reality.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: getFontSize(24))),
                              ])),
                        const Spacer(
                          flex: 1,
                        ),
                        if (!this.canLeave)
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
                                        child: Text(
                                          "[I am War] Fight a Boss from Act 1. Obtain a Rare Relic, normal rewards and 50 (25) gold.",
                                          style: TextStyle(
                                              fontSize: getFontSize(24)),
                                        )),
                                  )),
                            ],
                          ),
                        if (!this.canLeave)
                          Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(12),
                                  child: ElevatedButton(
                                    onPressed: richTapHandler,
                                    // style: ElevatedButton.styleFrom(
                                    //     surfaceTintColor: Colors.greenAccent),
                                    child: Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            "[I am Rich] Gain 999 gold. Become Cursed - 2 Normalities.",
                                            style: TextStyle(
                                                fontSize: getFontSize(24)),
                                          )),
                                    ),
                                  )),
                            ],
                          ),
                        if (!this.canLeave)
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
                                      child: Text(
                                        "[I am Healthy] Heal to full HP. Become Cursed - Doubt.",
                                        style: TextStyle(
                                            fontSize: getFontSize(24)),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        if (this.canLeave)
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
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                            fontSize: getFontSize(24)),
                                      )),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              left: 40,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 180, 10),
                color: Colors.amberAccent,
                child: Text('Mind Bloom',
                    style: TextStyle(
                        color: Colors.black, fontSize: getFontSize(24))),
              ),
            ),
          ],
        ));
  }
}

// [I am War] Fight a Boss from Act 1. Obtain a Rare Relic, normal rewards and 50 (25) gold.
// [I am Awake] Upgrade all Cards. Obtain MarkoftheBloom.png Mark of the Bloom, prohibiting you from healing.
// [I am Rich] Gain 999 gold. Become Cursed - 2 Normalities.
// [I am Healthy] Heal to full HP. Become Cursed - Doubt.