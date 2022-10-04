import 'dart:math';
import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/relic/wrist_blade.relic.dart';

const maxPrecisionChance = 100;
const minDodgeChance = 0;

Color getUpgradedCardColor() => Colors.greenAccent;

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
  if (character.mathMultiplierTime > 0) {
    localDamage = (localDamage * character.mathMultiplierScore).toInt();
    character.addMathMultiplierTime(-1);
  }
  if (character.mathMultiplierTime == 0) {
    character.mathMultiplierScore = 0;
  }
  return localDamage;
}

int calculateBlock({required int block, int mana = 2}) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();
  return predictBlock(block: block, mana: mana);
}

int predictBlock({required int block, int mana = 2}) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();

  int localBlock = block + character.dexterity;
  // localBlock
  return localBlock;
}

bool getProbability(int probability) => Random().nextInt(100) <= probability;
