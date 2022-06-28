import '../interfaces/character.interface.dart';

class BaseCharacter implements ICharacter {
  late String name;
  @override
  late int health;
  @override
  late int maxHealth;
  int block = 0;
  int vulnerable = 0;

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

  recieveDamage(int damage) {
    double localDamage = damage as double;
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
}
