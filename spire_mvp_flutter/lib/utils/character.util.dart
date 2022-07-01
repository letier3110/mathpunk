import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';

String getCharacterAssetByName(PlayerCharacter? pc) {
  switch (pc?.name) {
    case 'Warrior':
      return 'assets/ironclad.jpg';
    case 'Mage':
      return 'assets/defect.jpg';
    case 'Rogue':
      return 'assets/rogue.jpg';
    case 'Enigma':
      return 'assets/enigma.jpg';
    default:
      return 'assets/ironclad.jpg';
  }
}
