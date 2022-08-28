import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/classes/relic/wrist_blade.relic.dart';

int calculateDamage({required int damage, int mana = 2}) {
  PlayerCharacter character = Player.getPlayerInstance().getCharacter();
  int localDamage = damage + character.strength;
  int weak = character.weak;
  if (weak > 0) {
    localDamage = (localDamage * 0.75).floor();
  }
  try {
    character.relics
        .firstWhere((element) => WristBlade.isRelicWristBlade(element))
        .play();
    if (mana == 0) {
      localDamage += 4;
    }
  } catch (e) {
    // print(e);
  }
  return localDamage;
}
