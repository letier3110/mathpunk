import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy.dart';
import 'package:spire_mvp_flutter/classes/moveset.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/intension.util.dart';

class EnemyPawnView extends StatefulWidget {
  final Enemy enemy;
  const EnemyPawnView({required this.enemy, Key? key}) : super(key: key);

  @override
  State<EnemyPawnView> createState() => EnemyPawnViewView();
}

class EnemyPawnViewView extends State<EnemyPawnView> {
  @override
  Widget build(BuildContext context) {
    var hp = widget.enemy.getHealth();
    var maxhp = widget.enemy.getMaxHealth();

    void onTapHandler() {
      // TODO: implement drawpile tap handler
    }

    return Positioned(
      bottom: 220,
      right: 220,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 300,
            width: 300,
            color: Colors.black,
            child: Center(
              child: Text(
                widget.enemy.name,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
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
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                  // border: Border.all(color: Colors.white, width: 2)
                ),
                child: Center(
                  child: Text(
                    '$hp / $maxhp',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
