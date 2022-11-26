import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class CharacterHitpoints extends ConsumerStatefulWidget {
  const CharacterHitpoints({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterHitpoints> createState() => CharacterHitpointsView();
}

class CharacterHitpointsView extends ConsumerState<CharacterHitpoints> {
  @override
  Widget build(BuildContext context) {
    final hp = ref
        .watch(playerCharacterProvider.select((value) => value?.health ?? '0'));
    final maxhp = ref.watch(
        playerCharacterProvider.select((value) => value?.maxHealth ?? '0'));

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
