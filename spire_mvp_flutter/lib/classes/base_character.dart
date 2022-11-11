import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dodge.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/vulnerable.status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/interfaces/character.interface.dart';
import 'package:mathpunk_cardgame/storage/status.storage.dart';

class BaseCharacter implements ICharacter {
  late String name;
  @override
  late int health;
  @override
  late int maxHealth;
  List<Status> statuses = [];

  int timesReceivedDamageInRound = 0;
  int timesPlayedCardsInRound = 0;

  BaseCharacter() : super() {
    health = 10;
    maxHealth = 10;
    name = '';
  }

  String getName() => name;
  String getNameTranslationKey(BuildContext context) => 'realityEchanterName';
  String getDescriptionTranslationKey(BuildContext context) =>
      'realityEchanterDescription';

  void addStatus(Status status) {
    List<Status> findStatus = statuses
        .where((element) => element.runtimeType == status.runtimeType)
        .toList();
    if (findStatus.isNotEmpty) {
      findStatus[0].addStack(status.stack);
    } else {
      statuses.add(status);
    }
  }

  void setStatus(Status status) {
    List<Status> findStatus = statuses
        .where((element) => element.runtimeType == status.runtimeType)
        .toList();
    if (findStatus.isNotEmpty) {
      findStatus[0].setStack(status.stack);
    } else {
      statuses.add(status);
    }
  }

  recieveDamage(int damage) {
    int dodgeChance = castStatusToInt(statuses, DodgeStatus);
    int vulnerable = castStatusToInt(statuses, VulnerableStatus);
    int block = castStatusToInt(statuses, BlockStatus);

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

  List<Status> getStatuses() => statuses;

  void resetRoundStatuses() {
    timesReceivedDamageInRound = 0;
    timesPlayedCardsInRound = 0;
    statuses = [];
  }

  addTimesReceivedDamageInRound(int timesReceivedDamageInRound) {
    this.timesReceivedDamageInRound += timesReceivedDamageInRound;
  }

  addTimesPlayedCardsInRound(int timesPlayedCardsInRound) {
    this.timesPlayedCardsInRound += timesPlayedCardsInRound;
  }

  factory BaseCharacter.fromJson(dynamic json) {
    BaseCharacter character = BaseCharacter();
    character.setHealth(int.parse(json['health']));
    character.setMaxHealth(int.parse(json['maxHealth']));
    character.addTimesReceivedDamageInRound(
        int.parse(json['timesReceivedDamageInRound']));
    character
        .addTimesPlayedCardsInRound(int.parse(json['timesPlayedCardsInRound']));

    character.statuses.addAll((json['statuses'] as List<Status>)
        .map((e) => statusFromJson(e))
        .toList());
    return character;
  }

  Map toJson() => {
        'name': name,
        'health': health,
        'maxHealth': maxHealth,
        'timesReceivedDamageInRound': timesReceivedDamageInRound,
        'timesPlayedCardsInRound': timesPlayedCardsInRound,
        'statuses': statuses.map((e) => statusToJson(e)).toList()
      };
}
