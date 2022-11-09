import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';
import 'package:mathpunk_cardgame/screens/character_select/character_description.dart';
import 'package:mathpunk_cardgame/utils/character.util.dart';

class CharacterDescriptionConsumer extends ConsumerStatefulWidget {
  const CharacterDescriptionConsumer({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterDescriptionConsumer> createState() =>
      _CharacterDescriptionConsumerState();
}

class _CharacterDescriptionConsumerState
    extends ConsumerState<CharacterDescriptionConsumer> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = ref.watch(playerCharacterProvider);

    final assetName = getCharacterAssetByName(playerCharacter);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 109 / 300,
      height: width * 76 / 300,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: pickDescriptionImage(playerCharacter == null, assetName),
            fit: BoxFit.cover),
      ),
      child: Row(children: [
        if (playerCharacter != null)
          CharacterDescription(playerCharacter: playerCharacter)
      ]),
    );
  }
}

AssetImage pickDescriptionImage(bool disabled, String assetName) {
  if (disabled) {
    return const AssetImage('assets/character_select_description.png');
  }
  return const AssetImage('assets/menu_bg_1.png');
}
