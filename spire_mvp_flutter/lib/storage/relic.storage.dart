import 'package:mathpunk_cardgame/classes/relic/art_of_war.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/burning_blood.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ninja_scroll.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_serpent.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_snake.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/wrist_blade.relic.dart';

import '../classes/relic/relic.dart';

Relic relicFromJson(dynamic json) {
  // String jsonName = json['name'] as String;
  // String jsonDescription = json['description'] as String;

  String jsonRuntime = json['_runtime'] as String;

  Relic relic;

  switch (jsonRuntime) {
    case 'BurningBloodRelic':
      relic = BurningBloodRelic();
      break;
    case 'RingOfSnake':
      relic = RingOfSnake();
      break;
    case 'RingOfSerpent':
      relic = RingOfSerpent();
      break;
    case 'NinjaScroll':
      relic = NinjaScroll();
      break;
    case 'WristBlade':
      relic = WristBlade();
      break;
    case 'ArtOfWar':
      relic = ArtOfWar();
      break;
    default:
      relic = BurningBloodRelic();
      break;
  }

  return relic;
}

Map relicToJson(Relic relic) =>
    {...relic.toJson(), '_runtime': relic.runtimeType.toString()};
