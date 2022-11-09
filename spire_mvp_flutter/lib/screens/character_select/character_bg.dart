import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/playerCharacter.provider.dart';
import 'package:mathpunk_cardgame/utils/character.util.dart';

class CharacterBg extends ConsumerStatefulWidget {
  const CharacterBg({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterBg> createState() => _CharacterBgState();
}

class _CharacterBgState extends ConsumerState<CharacterBg> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = ref.watch(playerCharacterProvider);

    var assetName = getCharacterAssetByName(playerCharacter);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 3 / 8,
      height: width / 4,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: pickCharacterImage(playerCharacter == null, assetName),
            fit: BoxFit.cover),
      ),
    );
  }
}

AssetImage pickCharacterImage(bool disabled, String assetName) {
  if (disabled) {
    return const AssetImage('assets/character_select_class.png');
  }
  return AssetImage(assetName);
}
