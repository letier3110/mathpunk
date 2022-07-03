import 'package:spire_mvp_flutter/classes/intension.dart';
import 'package:spire_mvp_flutter/classes/moveset.dart';
import 'package:spire_mvp_flutter/enums/intension_type.dart';

import 'enemy.dart';

class EnemyGoblin extends Enemy {
  EnemyGoblin({String enemyName = 'goblin'}) : super(enemyName: enemyName) {
    moveset = Moveset();
    moveset.setMoves(
        [Intension(intensionType: IntensionType.offense, intensionDamage: 5)]);
  }
}
