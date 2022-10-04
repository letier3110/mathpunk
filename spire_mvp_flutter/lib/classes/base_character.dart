import 'package:mathpunk_cardgame/classes/util.dart';

import '../interfaces/character.interface.dart';

class BaseCharacter implements ICharacter {
  late String name;
  @override
  late int health;
  @override
  late int maxHealth;
  int block = 0;
  int vulnerable = 0;
  int weak = 0;
  int strength = 0;
  int dexterity = 0;
  int strengthEmpower = 0;
  int dexterityEmpower = 0;
  int strengthCurse = 0;
  int dexterityCurse = 0;
  int timesReceivedDamageInRound = 0;
  int dodgeChance = 0;
  int precisionChance = maxPrecisionChance;
  double mathMultiplierScore = 0;
  int mathMultiplierTime = 0;

  BaseCharacter() : super() {
    health = 10;
    maxHealth = 10;
    name = '';
  }

  statusUpdate() {
    block = 0;
    if (vulnerable >= 1) {
      vulnerable -= 1;
    }
  }

  addBlock(int block) {
    this.block += block;
  }

  addVulnerable(int vulnerable) {
    this.vulnerable += vulnerable;
  }

  addWeak(int weak) {
    this.weak += weak;
  }

  addStrength(int strength) {
    this.strength += strength;
  }

  addStrengthCurse(int strengthCurse) {
    this.strengthCurse += strengthCurse;
  }

  addStrengthEmpower(int strengthEmpower) {
    this.strengthEmpower += strengthEmpower;
  }

  addDexterity(int dexterity) {
    this.dexterity += dexterity;
  }

  addDexterityCurse(int dexterityCurse) {
    this.dexterityCurse += dexterityCurse;
  }

  addDexterityEmpower(int dexterityEmpower) {
    this.dexterityEmpower += dexterityEmpower;
  }

  addTimesReceivedDamageInRound(int timesReceivedDamageInRound) {
    this.timesReceivedDamageInRound += timesReceivedDamageInRound;
  }

  addDodgeChance(int dodgeChance) {
    this.dodgeChance += dodgeChance;
  }

  addPrecisionChance(int precisionChance) {
    this.precisionChance += precisionChance;
  }

  addMathMultiplierScore(double mathMultiplierScore) {
    this.mathMultiplierScore += mathMultiplierScore;
  }

  addMathMultiplierTime(int mathMultiplierTime) {
    this.mathMultiplierTime += mathMultiplierTime;
  }

  void resetRoundStatuses() {
    timesReceivedDamageInRound = 0;
  }

  recieveDamage(int damage) {
    if (getProbability(dodgeChance)) {
      return;
    }
    double localDamage = damage.toDouble();
    if (vulnerable > 1) {
      localDamage = damage * 1.5;
    }

    if (block > 0) {
      var tempBlock = block;
      block -= localDamage.floor();
      localDamage -= tempBlock;
    }

    if (localDamage > 0) {
      health -= localDamage.floor();
    }
    addTimesReceivedDamageInRound(1);
  }

  heal(int damage) {
    if (damage > 0) {
      int newHealth = (health + damage);
      if (newHealth > health) {
        health = maxHealth;
      } else {
        health = newHealth;
      }
    }
  }

  @override
  getHealth() {
    return health;
  }

  @override
  getMaxHealth() {
    return maxHealth;
  }

  @override
  setHealth(int health) {
    this.health = health;
  }

  @override
  changeHealth(int health) {
    this.health -= health;
  }

  @override
  setMaxHealth(int maxHealth) {
    this.maxHealth = maxHealth;
  }

  getDodgeChance() {
    return dodgeChance;
  }

  getPrecisionChance() {
    return precisionChance;
  }

  factory BaseCharacter.fromJson(dynamic json) {
    BaseCharacter character = BaseCharacter();
    character.setHealth(json['health'] as int);
    character.setMaxHealth(json['maxHealth'] as int);
    character.addBlock(json['block'] as int);
    character.addVulnerable(json['vulnerable'] as int);
    character.addWeak(json['weak'] as int);
    character.addStrength(json['strength'] as int);
    character.addStrengthCurse(json['strengthCurse'] as int);
    character.addStrengthEmpower(json['strengthEmpower'] as int);
    character.addDexterity(json['dexterity'] as int);
    character.addDexterityCurse(json['dexterityCurse'] as int);
    character.addDexterityEmpower(json['dexterityEmpower'] as int);
    character.addTimesReceivedDamageInRound(
        json['timesReceivedDamageInRound'] as int);
    character.addDodgeChance(json['dodgeChance'] as int);
    character.addPrecisionChance(json['precisionChance'] as int);
    character.addMathMultiplierScore(json['mathMultiplierScore'] as double);
    character.addMathMultiplierTime(json['mathMultiplierTime'] as int);

    return character;
  }

  Map toJson() => {
        'name': name,
        'health': health,
        'maxHealth': maxHealth,
        'block': block,
        'vulnerable': vulnerable,
        'weak': weak,
        'strength': strength,
        'strengthCurse': strengthCurse,
        'strengthEmpower': strengthEmpower,
        'dexterity': dexterity,
        'dexterityCurse': dexterityCurse,
        'dexterityEmpower': dexterityEmpower,
        'timesReceivedDamageInRound': timesReceivedDamageInRound,
        'dodgeChance': dodgeChance,
        'precisionChance': precisionChance,
        'mathMultiplierScore': mathMultiplierScore,
        'mathMultiplierTime': mathMultiplierTime,
      };
}
