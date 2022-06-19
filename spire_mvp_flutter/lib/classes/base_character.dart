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
