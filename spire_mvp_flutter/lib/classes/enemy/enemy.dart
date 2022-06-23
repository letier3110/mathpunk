import '../base_character.dart';
import '../moveset.dart';

class Enemy implements BaseCharacter {
  @override
  late String name;
  @override
  late int health;
  @override
  late int maxHealth;
  late int armor;
  late Moveset moveset;

  Enemy(
      {String enemyName = '',
      int enemyHealth = 5,
      int enemyMaxHealth = 5,
      int enemyArmor = 0})
      : super() {
    name = enemyName;
    health = enemyHealth;
    maxHealth = enemyMaxHealth;
    armor = enemyArmor;
    moveset = Moveset();
    // this.moveset.getNextMove();
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

  getArmor() {
    return armor;
  }

  makeMove() {
    if (health > 0) {
      moveset.executeMove();
    }
    moveset.getNextMove();
  }
}
