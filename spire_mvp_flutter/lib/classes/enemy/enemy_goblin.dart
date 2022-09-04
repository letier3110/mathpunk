import 'package:mathpunk_cardgame/classes/intension.dart';
import 'package:mathpunk_cardgame/classes/moveset.dart';
import 'package:mathpunk_cardgame/enums/intension_type.enum.dart';

import 'enemy.dart';

class EnemyGoblin extends Enemy {
  EnemyGoblin({String enemyName = 'goblin'})
      : super(enemyName: enemyName, enemyMaxHealth: 10, enemyHealth: 10) {
    moveset = Moveset();
    moveset.setMoves([
      Intension(intensionType: IntensionType.offense, intensionDamage: 5),
      Intension(intensionType: IntensionType.offense, intensionDamage: 4),
      Intension(intensionType: IntensionType.offense, intensionDamage: 6)
    ]);
  }
}
