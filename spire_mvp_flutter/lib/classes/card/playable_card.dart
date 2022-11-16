import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/card_description.dart';
import 'package:mathpunk_cardgame/components/card_mana.dart';
import 'package:mathpunk_cardgame/components/card_name.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';
import 'package:mathpunk_cardgame/enums/resources.enum.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';
import 'package:mathpunk_cardgame/storage/card_effect.storage.dart';
import 'package:mathpunk_cardgame/storage/playable_card.storage.dart';

import '../../enums/card_type.enum.dart';

class PlayableCard {
  late int mana;
  late CardType type;
  late TargetEnum targetType = TargetEnum.singleTarget;
  CardState currentState;
  late int currentEffectId;
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
  List<CardEffect> effects = [];

  PlayableCard(
      {this.currentState = CardState.empty,
      this.asset = 'assets/cards/anger.png',
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
      cardTemporary = false,
      List<CardEffect> cardEffect = const [],
      cardCurrentEffectId}) {
    ethereal = cardEthereal;
    exhausted = cardExhaused;
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
    effects = [];
    // keep effects unique
    for (var i = 0; i < cardEffect.length; i++) {
      cardEffect[i].setId(i);
    }
    effects = cardEffect;
    currentEffectId = cardCurrentEffectId;
  }

  bool isCardBoosted() => false;

  bool isCardCanBeUpgraded() => upgradeCardLink != null;

  PlayableCard upgradeCard() {
    if (upgradeCardLink != null) {
      return upgradeCardLink!;
    }
    return this;
  }

  StatefulWidget getCardName(BuildContext context) {
    return const CardName(isUpgraded: false);
  }

  StatefulWidget getCardDescription() {
    return CardDescription(
      effects: effects,
    );
  }

  StatelessWidget getCardMana() {
    return CardMana(
      currentMana: getMana(),
      cardMana: mana,
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

  factory PlayableCard.fromJson(dynamic json) {
    var card = json['upgradeCardLink'];
    return PlayableCard(
        cardMana: int.parse(json['mana']),
        cardSteps: int.parse(json['step']),
        cardMaxSteps: int.parse(json['maxSteps']),
        cardExhaused: json['exhausted'] as bool,
        cardEthereal: json['ethereal'] as bool,
        cardPrecision: int.parse(json['precision']),
        cardTemporary: json['temporary'] as bool,
        cardCurrentEffectId: json['currentEffectId'] as int,
        cardType: decodeCardTypeFromJson(json['type']),
        cardTargetType: decodeTargetEnumFromJson(json['targetType']),
        cardUpgrageLink: card == null
            ? null
            : PlayableCard.fromJson(json['upgradeCardLink']),
        cardResource: decodeResourcesFromJson(json['resourceType']),
        cardSelectedCards: (json['selectedCards'] as List)
            .map((e) => playableCardFromJson(json))
            .toList(),
        currentState: decodeCardStateFromJson(json['currentState']),
        cardEffect: (json['effects'] as List)
            .map((e) => cardEffectFromJson(e))
            .toList());
  }

  Map toJson() => {
        'mana': mana,
        'step': step,
        'maxSteps': maxSteps,
        'exhausted': exhausted,
        'ethereal': ethereal,
        'precision': precision,
        'temporary': temporary,
        'currentEffectId': currentEffectId,
        'type': type.toString(),
        'currentState': currentState.toString(),
        'targetType': targetType.toString(),
        'resourceType': resourceType.toString(),
        'selectedCards': selectedCards.map((e) => e.toJson()).toList(),
        'upgradeCardLink':
            upgradeCardLink == null ? null : upgradeCardLink!.toJson(),
        'effects': effects.map((e) => cardEffectToJson(e)).toList()
      };
}

// gamestate.playTheCard(card)
// => set state card.currentState = CardState.playingEffects
// => start timer with card.effects.map(x => x.isUserInteractionRequired ? break : x.playEffect()); 
// => x.playEffect() + (currentEffectId = effect.id)
// => if interaction => 
// => => show new ui element
// => => effect.selectTarget + card.effects[card.currentEffectId].playEffect()
// => => + resume Timer from last id+1
// => => if last id+1 not exist => card.currentState = CardState.discard + check if possible