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
  }

  makeMove() {
    if (health > 0) {
      moveset.executeMove(this);
    }
    moveset.getNextMove();
  }

  initMove() {
    moveset.getNextMove();
  }

  void setMoveset(Moveset moveset) {
    this.moveset = moveset;
  }

  factory Enemy.fromJson(dynamic json) {
    Enemy character = (BaseCharacter.fromJson(json)) as Enemy;
    Moveset jsonMoveset = Moveset.fromJson(json['moveset']);
    character.setMoveset(jsonMoveset);

    return character;
  }

  @override
  Map toJson() => {
        ...super.toJson(),
        'moveset': moveset,
      };
}
