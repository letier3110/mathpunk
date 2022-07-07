import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';
import 'package:spire_mvp_flutter/utils/intension.util.dart';

const double hpBarHeight = 20;

class EnemyPawnView extends StatefulWidget {
  final Enemy enemy;
  const EnemyPawnView({required this.enemy, Key? key}) : super(key: key);

  @override
  State<EnemyPawnView> createState() => EnemyPawnViewView();
}

class EnemyPawnViewView extends State<EnemyPawnView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var hp = widget.enemy.getHealth();
    var maxhp = widget.enemy.getMaxHealth();

    bool isPlayerAlive = gameState.playerCharacter!.health > 0;

    void onTapHandler() {
      // TODO: implement drawpile tap handler
    }

    return Positioned(
      top: 100,
      right: 220,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 300,
            width: 300,
            child: Center(
              child: Text(
                widget.enemy.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getFontSize(22),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          if (isPlayerAlive)
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 50,
                  child: Center(
                    child: Text(
                      getIntensionType(widget.enemy.moveset.currentMove!),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getFontSize(16),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
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
                              color: Colors.redAccent,
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
                    Container(
                      padding: const EdgeInsets.all(2),
                      height: hpBarHeight,
                      child: Center(
                        child: Text(
                          '$hp / $maxhp',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getFontSize(16),
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
