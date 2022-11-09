import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class CharacterHitpoints extends ConsumerStatefulWidget {
  const CharacterHitpoints({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterHitpoints> createState() => CharacterHitpointsView();
}

class CharacterHitpointsView extends ConsumerState<CharacterHitpoints> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider);

    var hp = gameState.playerCharacter?.health ?? '0';
    var maxhp = gameState.playerCharacter?.maxHealth ?? '0';

    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(width * 1.5 / 16 + 10, 0, 0, 0),
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 4),
          child: const Icon(
            Icons.favorite,
            color: Colors.redAccent,
          ),
        ),
        Text(
          '$hp / $maxhp',
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 22,
              fontWeight: FontWeight.w600),
        ),
      ]),
    );
  }
}
