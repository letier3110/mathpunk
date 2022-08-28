import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';

String getCharacterAssetByName(PlayerCharacter? pc) {
  switch (pc?.name) {
    case 'Barbarian':
      return 'assets/barbarian_w.png';
    case 'Priest':
      return 'assets/priest.png';
    case 'Irrationalist':
      return 'assets/irrationalist.png';
    case 'Enigma':
      return 'assets/enigma_w.png';
    default:
      return 'assets/barbarian_w.png';
  }
}
