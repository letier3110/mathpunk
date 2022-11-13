import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/anger_card/anger_card.description.dart';
import 'package:mathpunk_cardgame/classes/card/anger_card/anger_card.name.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/enums/resources.enum.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';
import 'package:mathpunk_cardgame/notifiers/player_character.notifier.dart';
import 'package:mathpunk_cardgame/storage/playable_card.storage.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';

class PlayableCard {
  late String name;
  late String description;
  late int mana;
  late CardType type;
  late TargetEnum targetType = TargetEnum.singleTarget;
  String asset;
  bool exhausted = false;
  bool ethereal = false;
  bool temporary = false;
  int step = 1;
  int maxSteps = 1;
  int precision = maxPrecisionChance;
  ResourcesEnum resourceType = ResourcesEnum.mana;
  PlayableCard? upgradeCardLink;
  // possible place of bugs with selectedCards logic
  List<PlayableCard> selectedCards = [];

  PlayableCard(
      {this.asset = 'assets/cards/anger.png',
      cardName = '',
      cardDescription = '',
      cardMana = 0,
      cardType = CardType.skill,
      cardTargetType = TargetEnum.singleTarget,
      cardSteps = 1,
      cardMaxSteps = 1,
      List<PlayableCard> cardSelectedCards = const [],
      cardEthereal = false,
      cardExhaused = false,
      cardPrecision = maxPrecisionChance,
      cardResource = ResourcesEnum.mana,
      cardUpgrageLink,
      cardTemporary = false}) {
    ethereal = cardEthereal;
    exhausted = cardExhaused;
    name = cardName;
    description = cardDescription;
    mana = cardMana;
    step = cardSteps;
    maxSteps = cardMaxSteps;
    type = cardType;
    targetType = cardTargetType;
    selectedCards = cardSelectedCards;
    precision = cardPrecision;
    resourceType = cardResource;
    upgradeCardLink = cardUpgrageLink;
    temporary = cardTemporary;
  }

  bool isCardBoosted() => false;

  bool isCardCanBeUpgraded() => upgradeCardLink != null;

  PlayableCard upgradeCard() {
    if (upgradeCardLink != null) {
      return upgradeCardLink!;
    }
    return this;
  }

  StatefulWidget getCardName() {
    return const AngerCardName();
  }

  StatefulWidget getCardDescription() {
    return const AngerCardDescription();
  }

  StatelessWidget getCardMana() {
    int currentMana = getMana();

    return Text(
      getMana().toString(),
      style: TextStyle(
          color: currentMana < mana
              ? Colors.greenAccent
              : currentMana > mana
                  ? Colors.redAccent
                  : Colors.white,
          fontSize: 14),
    );
  }

  bool getExhausted() {
    return exhausted;
  }

  int getMana() {
    return mana;
  }

  void setMana(int mana) {
    this.mana = mana;
  }

  List<PlayableCard> getSelectableCards() {
    // only for cards with targetEnum.cardTarget
    throw UnimplementedError();
  }

  void setSelectedCards(List<PlayableCard> selectedCards) {
    this.selectedCards = selectedCards;
  }

  int getMaxSelectableCards() {
    // only for cards with targetEnum.cardTarget
    throw UnimplementedError();
  }

  bool disposeToDiscard(
      List<PlayableCard> hand, List<PlayableCard> discardPile) {
    if (!ethereal) {
      discardPile.add(this);
    }
    hand.remove(this);
    return true;
  }

  bool isCardPlayable() => true;

  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    // can be failed,
    // because of not correctly loaded from memory state or wrongly casted.
    // PlayableCard class in not used directly, only as Generic Type
    throw UnimplementedError();
  }

  factory PlayableCard.fromJson(dynamic json) {
    var card = json['upgradeCardLink'];
    return PlayableCard(
        cardName: json['name'] as String,
        cardDescription: json['description'] as String,
        cardMana: int.parse(json['mana']),
        cardSteps: int.parse(json['step']),
        cardMaxSteps: int.parse(json['maxSteps']),
        cardExhaused: json['exhausted'] as bool,
        cardEthereal: json['ethereal'] as bool,
        cardPrecision: int.parse(json['precision']),
        cardTemporary: json['temporary'] as bool,
        cardType: decodeCardTypeFromJson(json['type']),
        cardTargetType: decodeTargetEnumFromJson(json['targetType']),
        cardUpgrageLink: card == null
            ? null
            : PlayableCard.fromJson(json['upgradeCardLink']),
        cardResource: decodeResourcesFromJson(json['resourceType']),
        cardSelectedCards: (json['selectedCards'] as List)
            .map((e) => playableCardFromJson(json))
            .toList());
  }

  Map toJson() => {
        'name': name,
        'description': description,
        'mana': mana,
        'step': step,
        'maxSteps': maxSteps,
        'exhausted': exhausted,
        'ethereal': ethereal,
        'precision': precision,
        'temporary': temporary,
        'type': type.toString(),
        'targetType': targetType.toString(),
        'resourceType': resourceType.toString(),
        'selectedCards': selectedCards.map((e) => e.toJson()).toList(),
        'upgradeCardLink':
            upgradeCardLink == null ? null : upgradeCardLink!.toJson(),
      };
}
