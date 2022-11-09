import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class CharacterItems extends ConsumerStatefulWidget {
  const CharacterItems({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterItems> createState() => CharacterItemsView();
}

class CharacterItemsView extends ConsumerState<CharacterItems> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = ref.watch(playerCharacterProvider);

    var items = playerCharacter?.items ?? [];

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(328, 0, 0, 0),
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: items
              .map((e) => SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(e.getAssetImage()),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Text(
                          e.getItemName(context),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.pinkAccent,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ))
              .toList()),
    );
  }
}
