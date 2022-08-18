import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/barbarian_character.dart';
import 'package:spire_mvp_flutter/utils/character.util.dart';

import 'package:spire_mvp_flutter/utils/font.util.dart';

class MindBloomView extends StatefulWidget {
  const MindBloomView({Key? key}) : super(key: key);

  @override
  State<MindBloomView> createState() => _MindBloomViewView();
}

class _MindBloomViewView extends State<MindBloomView> {
  @override
  Widget build(BuildContext context) {
    void onTapHandler() {}
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
                        Text(
                            'While walking and traversing through the chaos of the Spire, your thoughts suddenly begin to feel very... real...',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getFontSize(24))),
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
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              child: ElevatedButton(
                                onPressed: onTapHandler,
                                // style: ElevatedButton.styleFrom(
                                //     surfaceTintColor: Colors.greenAccent),
                                child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      "[I am War] Fight a Boss from Act 1. Obtain a Rare Relic, normal rewards and 50 (25) gold.",
                                      style:
                                          TextStyle(fontSize: getFontSize(24)),
                                    )),
                              )),
                        ),
                        Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(12),
                                child: ElevatedButton(
                                  onPressed: onTapHandler,
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
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              child: ElevatedButton(
                                onPressed: onTapHandler,
                                // style: ElevatedButton.styleFrom(
                                //     surfaceTintColor: Colors.greenAccent),
                                child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      "[I am Healthy] Heal to full HP. Become Cursed - Doubt.",
                                      style:
                                          TextStyle(fontSize: getFontSize(24)),
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