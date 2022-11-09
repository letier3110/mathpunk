import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/playerCharacter.provider.dart';
import 'package:mathpunk_cardgame/controllers/saves.provider.dart';

class CharacterName extends ConsumerStatefulWidget {
  const CharacterName({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterName> createState() => CharacterNameView();
}

class CharacterNameView extends ConsumerState<CharacterName> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = ref.watch(playerCharacterProvider);
    final saves = ref.watch(savesProvider);

    var playerName = saves.saveSlots[saves.currentSaveSlot ?? 0];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              playerName,
              // '$height',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(
                playerCharacter!.getNameTranslationKey(context),
                // '$width',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ]),
    );
  }
}
