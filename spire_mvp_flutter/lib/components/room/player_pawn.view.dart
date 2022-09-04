import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';
import 'package:mathpunk_cardgame/utils/font.util.dart';

const double hpBarHeight = 20;

class PlayerPawnView extends StatefulWidget {
  const PlayerPawnView({Key? key}) : super(key: key);

  @override
  State<PlayerPawnView> createState() => PlayerPawnViewView();
}

class PlayerPawnViewView extends State<PlayerPawnView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var block = gameState.playerCharacter?.block ?? 0;
    var hp = gameState.playerCharacter?.health ?? 0;
    var maxhp = gameState.playerCharacter?.maxHealth ?? 0;
    bool isPlayerAlive = gameState.playerCharacter!.health > 0;

    double width = MediaQuery.of(context).size.width;

    void onTapHandler() {
      // TODO: implement drawpile tap handler
    }

    return Positioned(
      top: 100,
      left: width / 6,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: width / 4,
            width: width / 4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/hero.png'), fit: BoxFit.cover),
            ),
            // child: Center(
            //   child: Text(
            //     'Player',
            //     textAlign: TextAlign.left,
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 22,
            //         fontWeight: FontWeight.w600),
            //   ),
            // ),
          ),
          if (isPlayerAlive)
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(2),
                        height: hpBarHeight,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(hpBarHeight),
                          // border: Border.all(color: Colors.white, width: 2)
                        )),
                    Row(
                      children: [
                        Expanded(
                          flex: ((hp / maxhp) * 100).toInt(),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            height: hpBarHeight,
                            decoration: BoxDecoration(
                              color:
                                  block > 0 ? Colors.purple : Colors.redAccent,
                              borderRadius: BorderRadius.circular(hpBarHeight),
                              // border: Border.all(color: Colors.white, width: 2)
                            ),
                          ),
                        ),
                        Expanded(
                          flex: (((maxhp - hp) / maxhp) * 100).toInt(),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            height: hpBarHeight,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(hpBarHeight),
                              // border: Border.all(color: Colors.white, width: 2)
                            ),
                          ),
                        )
                      ],
                    ),
                    if (block > 0)
                      Positioned(
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          height: hpBarHeight,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(hpBarHeight),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(
                                    Icons.shield,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                                Text(
                                  '$block',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      height: hpBarHeight,
                      child: Center(
                        child: Text(
                          '$hp / $maxhp',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ))
        ]),
      ),
    );
  }
}
