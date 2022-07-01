import 'player_character/player_character.dart';

class Player {
  late String name;
  late PlayerCharacter? character;

  static Player? instance;

  static Player getPlayerInstance() {
    return instance ?? Player();
  }

  // TODO: add player name in profile before main menu and preserve it
  constructor({newName = 'Test player'}) {
    name = newName;
    character = null;
    instance = this;
  }

  getName() {
    return name;
  }

  selectCharacter(PlayerCharacter newCharacter) {
    character = newCharacter;
  }

  getCharacter() {
    return character;
  }
}
