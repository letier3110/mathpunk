import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';

PlayerCharacter playerCharacterFromJson(dynamic json) {
  PlayerCharacter character = PlayerCharacter();
  character.setHealth(json['health'] as int);
  character.setMaxHealth(json['maxHealth'] as int);
  character.addBlock(json['block'] as int);
  character.addVulnerable(json['vulnerable'] as int);

  return character;
}

Map playerCharacterToJson(PlayerCharacter character) => {
      'name': character.name,
      'health': character.health,
      'maxHealth': character.maxHealth,
      'block': character.block,
      'vulnerable': character.vulnerable
    };
