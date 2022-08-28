import 'package:spire_mvp_flutter/classes/intension.dart';
import 'package:spire_mvp_flutter/classes/moveset.dart';
import 'package:spire_mvp_flutter/enums/intension_type.enum.dart';

import 'enemy.dart';

class EnemyOgre extends Enemy {
  EnemyOgre({String enemyName = 'ogre'})
      : super(enemyName: enemyName, enemyMaxHealth: 120, enemyHealth: 120) {
    moveset = Moveset();
    moveset.setMoves([
      Intension(intensionType: IntensionType.offense, intensionDamage: 5),
      Intension(intensionType: IntensionType.offense, intensionDamage: 4),
      Intension(intensionType: IntensionType.offense, intensionDamage: 6)
    ]);
  }
}
