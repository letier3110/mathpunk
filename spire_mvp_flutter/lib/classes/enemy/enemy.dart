import '../base_character.dart';
import '../moveset.dart';

class Enemy extends BaseCharacter {
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
    block = enemyArmor;
    moveset = Moveset();
    // this.moveset.getNextMove();
  }

  makeMove() {
    if (health > 0) {
      moveset.executeMove();
    }
    moveset.getNextMove();
  }
}
