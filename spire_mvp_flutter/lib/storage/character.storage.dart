import 'package:spire_mvp_flutter/classes/player/player_character/barbarian_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/enigma_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/irrationalist_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/priest_character.dart';
import 'package:spire_mvp_flutter/storage/consumable_item.storage.dart';
import 'package:spire_mvp_flutter/storage/relic.storage.dart';

import '../classes/deck.dart';
import '../classes/items/consumable_item.dart';
import '../classes/relic/relic.dart';

PlayerCharacter playerCharacterFromJson(dynamic json) {
  Deck jsonDeck = Deck.fromJson(json['deck']);
  List<Relic> jsonRelic =
      (json['relics'] as List).map((e) => relicFromJson(e)).toList();
  List<ConsumableItem> jsonItem =
      (json['items'] as List).map((e) => consumableItemFromJson(e)).toList();
  int jsonMana = json['mana'] as int;
  int jsonManaPower = json['manaPower'] as int;
  int jsonDrawPower = json['drawPower'] as int;
  int jsonGold = json['gold'] as int;

  int jsonHealth = json['health'] as int;
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

  character.setRelics(jsonRelic);
  character.setItems(jsonItem);
  character.setMana(jsonMana);
  character.setManaPower(jsonManaPower);
  character.setDrawPower(jsonDrawPower);
  character.setGold(jsonGold);

  character.setDeck(jsonDeck);

  character.setHealth(jsonHealth);
  character.setMaxHealth(jsonMaxHealth);
  character.addBlock(jsonBlock);
  character.addVulnerable(jsonVulnerable);

  return character;
}

Map playerCharacterToJson(PlayerCharacter character) =>
    {...character.toJson(), '_runtime': character.runtimeType.toString()};
