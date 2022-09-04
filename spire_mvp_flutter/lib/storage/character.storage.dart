import 'package:mathpunk_cardgame/classes/player/player_character/barbarian_character.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/enigma_character.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/irrationalist_character.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/priest_character.dart';
import 'package:mathpunk_cardgame/storage/consumable_item.storage.dart';
import 'package:mathpunk_cardgame/storage/relic.storage.dart';

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

  int jsonWeak = json['weak'] as int;
  int jsonStrength = json['strength'] as int;
  int jsonStrengthCurse = json['strengthCurse'] as int;
  int jsonStrengthEmpower = json['strengthEmpower'] as int;

  int jsonTimesReceivedDamageInRound =
      json['timesReceivedDamageInRound'] as int;

  int jsonCardsPlayedInRound = json['cardsPlayedInRound'] as int;

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

  character.addWeak(jsonWeak);
  character.addStrength(jsonStrength);
  character.addStrengthCurse(jsonStrengthCurse);
  character.addStrengthEmpower(jsonStrengthEmpower);

  character.addTimesReceivedDamageInRound(jsonTimesReceivedDamageInRound);

  character.addCardsPlayedInRound(jsonCardsPlayedInRound);

  return character;
}

Map playerCharacterToJson(PlayerCharacter character) =>
    {...character.toJson(), '_runtime': character.runtimeType.toString()};
