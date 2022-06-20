class ICharacter {
  late int health;
  late int maxHealth;
  int getHealth() {
    return 0;
  }

  int getMaxHealth() {
    return 0;
  }

  setHealth(int health) {}
  changeHealth(int health) {}
  setMaxHealth(int health) {}
  ICharacter() {
    health = 0;
    maxHealth = 0;
  }
}

class BaseCharacter implements ICharacter {
  late String name;
  @override
  late int health;
  @override
  late int maxHealth;

  BaseCharacter() {
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
