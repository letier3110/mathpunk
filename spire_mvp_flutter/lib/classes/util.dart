import 'dart:math';
import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';
import 'package:mathpunk_cardgame/classes/relic/wrist_blade.relic.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_time.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/precision.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/weak.status.dart';

const maxPrecisionChance = 100;
const minDodgeChance = 0;

Color getUpgradedCardColor() => Colors.greenAccent;

int calculateDamage(
    {required int damage, int mana = 2, int strengthModifier = 1}) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();

  List<Status> statuses = character.getStatuses();
  int precisionChance = castStatusToInt(statuses, PrecisionStatus);
  int mathMultiplierTime = castStatusToInt(statuses, MathMultiplierTimeStatus);

  if (getProbability(precisionChance)) {
    return 0;
  }
  int predictedDamage = predictDamage(
      damage: damage, mana: mana, strengthModifier: strengthModifier);

  if (mathMultiplierTime > 0) {
    MathMultiplierScoreStatus ms = MathMultiplierScoreStatus();
    ms.addStack(-1);
    character.addStatus(ms);
  }
  if (mathMultiplierTime == 0) {
    MathMultiplierScoreStatus ms = MathMultiplierScoreStatus();
    character.addStatus(ms);
  }
  return predictedDamage;
}

int predictDamage(
    {required int damage, int mana = 2, int strengthModifier = 1}) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();

  List<Status> statuses = character.getStatuses();
  int strength = castStatusToInt(statuses, StrengthStatus);
  int weak = castStatusToInt(statuses, WeakStatus);
  int mathMultiplierTime = castStatusToInt(statuses, MathMultiplierTimeStatus);
  double mathMultiplierScore =
      castStatusToDouble(statuses, MathMultiplierScoreStatus);

  int localDamage = damage + strength * strengthModifier;
  if (weak > 0) {
    localDamage = (localDamage * 0.75).floor();
  }
  List<Relic> wristBlade = character.relics
      .where((element) => WristBlade.isRelicWristBlade(element))
      .toList();
  if (wristBlade.isNotEmpty) {
    wristBlade[0].play();
    if (mana == 0) {
      localDamage += 4;
    }
  }
  if (mathMultiplierTime > 0) {
    localDamage = (localDamage * mathMultiplierScore).toInt();
  }
  return localDamage;
}

int calculateBlock({required int block, int mana = 2}) {
  return predictBlock(block: block, mana: mana);
}

int predictBlock({required int block, int mana = 2}) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();

  List<Status> statuses = character.getStatuses();
  int dexterity = castStatusToInt(statuses, DexterityStatus);

  int localBlock = block + dexterity;
  return localBlock;
}

bool getProbability(int probability) => Random().nextInt(100) <= probability;

int castStatusToInt(List<Status> statuses, Type runtime) {
  List<Status> statusList =
      statuses.where((element) => element.runtimeType == runtime).toList();
  if (statusList.isNotEmpty) return statusList[0].stack.round();
  return 0;
}

bool castStatusToBool(List<Status> statuses, Type runtime) {
  List<Status> statusList =
      statuses.where((element) => element.runtimeType == runtime).toList();
  if (statusList.isNotEmpty) return statusList[0].stack == 0;
  return false;
}

double castStatusToDouble(List<Status> statuses, Type runtime) {
  List<Status> statusList =
      statuses.where((element) => element.runtimeType == runtime).toList();
  if (statusList.isNotEmpty) return statusList[0].stack;
  return 0;
}
