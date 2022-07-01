import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class CharacterHitpoints extends StatefulWidget {
  const CharacterHitpoints({Key? key}) : super(key: key);

  @override
  State<CharacterHitpoints> createState() => CharacterHitpointsView();
}

class CharacterHitpointsView extends State<CharacterHitpoints> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var hp = gameState.playerCharacter?.health ?? '0';
    var maxhp = gameState.playerCharacter?.maxHealth ?? '0';

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(150, 0, 0, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HP: $hp / $maxhp',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.red, fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ]),
    );
  }
}
