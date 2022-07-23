import 'package:spire_mvp_flutter/classes/intension.dart';
import 'package:spire_mvp_flutter/classes/moveset.dart';
import 'package:spire_mvp_flutter/enums/intension_type.enum.dart';

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
