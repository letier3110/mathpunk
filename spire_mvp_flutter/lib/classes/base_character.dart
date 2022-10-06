import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/interfaces/character.interface.dart';

class BaseCharacter implements ICharacter {
  late String name;
  @override
  late int health;
  @override
  late int maxHealth;
  List<Status> statuses = [];

  // int block = 0;
  // int vulnerable = 0;
  // int weak = 0;
  // int strength = 0;
  // int dexterity = 0;
  // int strengthEmpower = 0;
  // int dexterityEmpower = 0;
  // int strengthCurse = 0;
  // int dexterityCurse = 0;

  int timesReceivedDamageInRound = 0;
  // int dodgeChance = 0;
  // int precisionChance = maxPrecisionChance;
  // double mathMultiplierScore = 0;
  // int mathMultiplierTime = 0;

  // bool blackPawn = false;
  // bool blackRook = false;
  // bool blackKnight = false;
  // bool blackBishop = false;
  // bool blackQueen = false;
  // bool blackKing = false;

  BaseCharacter() : super() {
    health = 10;
    maxHealth = 10;
    name = '';
  }

  void addStatus(Status status) {
    statuses.add(status);
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

  addTimesReceivedDamageInRound(int timesReceivedDamageInRound) {
    this.timesReceivedDamageInRound += timesReceivedDamageInRound;
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

    character.setBlackPawn(json['blackPawn'] as bool);
    character.setBlackRook(json['blackRook'] as bool);
    character.setBlackKnight(json['blackKnight'] as bool);
    character.setBlackBishop(json['blackBishop'] as bool);
    character.setBlackQueen(json['blackQueen'] as bool);
    character.setBlackKing(json['blackKing'] as bool);

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
        'blackPawn': blackPawn,
        'blackRook': blackRook,
        'blackKnight': blackKnight,
        'blackBishop': blackBishop,
        'blackQueen': blackQueen,
        'blackKing': blackKing,
      };
}
