import 'package:spire_mvp_flutter/classes/player/player_character/barbarian_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/enigma_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/irrationalist_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/priest_character.dart';

PlayerCharacter playerCharacterFromJson(dynamic json) {
  int jsonHelath = json['health'] as int;
  int jsonMaxHealth = json['maxHealth'] as int;
  int jsonBlock = json['block'] as int;
  int jsonVulnerable = json['vulnerable'] as int;

  String jsonRuntime = json['_runtime'] as String;

  PlayerCharacter character;

  switch (jsonRuntime) {
    case 'Barbarian':
      character = Barbarian();
      break;
    case 'Priest':
      character = Priest();
      break;
    case 'Irrationalist':
      character = Irrationalist();
      break;
    case 'Enigma':
      character = Enigma();
      break;
    default:
      character = Barbarian();
      break;
  }

  character.setHealth(jsonHelath);
  character.setMaxHealth(jsonMaxHealth);
  character.addBlock(jsonBlock);
  character.addVulnerable(jsonVulnerable);

  return character;
}

Map playerCharacterToJson(PlayerCharacter character) =>
    {...character.toJson(), '_runtime': character.runtimeType};
