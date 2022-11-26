import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class CharacterGold extends ConsumerStatefulWidget {
  const CharacterGold({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterGold> createState() => CharacterGoldView();
}

class CharacterGoldView extends ConsumerState<CharacterGold> {
  @override
  Widget build(BuildContext context) {
    final gold = ref
        .watch(playerCharacterProvider.select((value) => value?.gold ?? '0'));

    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(width * 1.5 / 16 + 10, 32, 0, 0),
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 4),
          child: const Icon(
            Icons.savings,
            color: Colors.yellow,
          ),
        ),
        Text(
          gold.toString(),
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Colors.yellow, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ]),
    );
  }
}
