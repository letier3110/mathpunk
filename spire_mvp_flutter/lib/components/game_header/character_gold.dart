import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class CharacterGold extends StatefulWidget {
  const CharacterGold({Key? key}) : super(key: key);

  @override
  State<CharacterGold> createState() => CharacterGoldView();
}

class CharacterGoldView extends State<CharacterGold> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var gold = gameState.playerCharacter?.gold ?? '0';

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(328, 0, 0, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gold: $gold',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: getFontSize(22),
                  fontWeight: FontWeight.w600),
            ),
          ]),
    );
  }
}
