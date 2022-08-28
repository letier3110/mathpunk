import '../classes/enemy/enemy.dart';
import '../classes/enemy/enemy_goblin.dart';
import '../classes/enemy/enemy_ork.dart';
import '../classes/enemy/enemy_slime.dart';

Enemy enemyFromJson(dynamic json) {
  String jsonRuntime = json['_runtime'] as String;

  Enemy enemy;

  switch (jsonRuntime) {
    case 'EnemyGoblin':
      enemy = EnemyGoblin();
      break;
    case 'EnemyOrk':
      enemy = EnemyOrk();
      break;
    case 'EnemySlime':
      enemy = EnemySlime();
      break;
    default:
      enemy = EnemyGoblin();
      break;
  }

  return enemy;
}

Map enemyToJson(Enemy enemy) =>
    {...enemy.toJson(), '_runtime': enemy.runtimeType.toString()};
