import 'dart:math';

import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_target_queue.dart';
import 'package:mathpunk_cardgame/classes/math/mathfunction.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/relic/wrist_blade.relic.dart';
import 'package:mathpunk_cardgame/storage/playable_card.storage.dart';

const maxPrecisionChance = 100;
const minDodgeChance = 0;

int calculateDamage(
    {required int damage, int mana = 2, int strengthModifier = 1}) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();

  if (getProbability(character.getPrecisionChance())) {
    return 0;
  }
  return predictDamage(
      damage: damage, mana: mana, strengthModifier: strengthModifier);
}

int predictDamage(
    {required int damage, int mana = 2, int strengthModifier = 1}) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();

  int localDamage = damage + character.strength * strengthModifier;
  int weak = character.weak;
  if (weak > 0) {
    localDamage = (localDamage * 0.75).floor();
  }
  try {
    character.relics
        .firstWhere((element) => WristBlade.isRelicWristBlade(element))
        .play();
    if (mana == 0) {
      localDamage += 4;
    }
  } catch (e) {
    // print(e);
  }
  return localDamage;
}

void addMathfunctionToPlayer(Mathfunction playableMathfunction) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();
  Mathfunction? mathfunction = character.getMathfunction();
  if (mathfunction == null) {
    character.addMathFunction(playableMathfunction);
    return;
  } else {
    Mathslot? slot = mathfunction.getFirstUndefinedSlot();
    if (slot == null) {
      // throw error - it cant be that we filled all slots
      // and not executed mathslots or cleared mathfunction
      return;
    }
    slot.assingMathfunction(playableMathfunction);
  }
}

bool addToCardMathfunctionAndExecuteQueue(
    PlayableCard card, List<BaseCharacter> target) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();
  Mathfunction? mathfunction = character.getMathfunction();
  if (mathfunction == null) {
    // or add to queue and immediately execute
    return false;
  }
  Mathslot? slot = mathfunction.getFirstUndefinedSlot();
  if (slot == null) {
    // throw error - it cant be that we filled all slots
    // and not executed mathslots or cleared mathfunction
    return false;
  }
  slot.assignCard(card);
  character.playableCardQueue.add(CardTargetQueue(card: card, target: target));
  // if last slot
  Mathslot? lastSlot = mathfunction.getFirstUndefinedSlot();
  if (lastSlot == null) {
    // traverse tree, from edge to root and apply to math modifiers to edges
    // and execute them
  }
  return true;
}

bool getProbability(int probability) => Random().nextInt(100) <= probability;
