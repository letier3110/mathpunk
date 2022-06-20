import '../interfaces/character.dart';

class BaseCharacter implements ICharacter {
  late String name;
  @override
  late int health;
  @override
  late int maxHealth;

  BaseCharacter() : super() {
    health = 10;
    maxHealth = 10;
    name = '';
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
