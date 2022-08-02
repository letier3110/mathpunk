import 'package:spire_mvp_flutter/classes/relic/burning_blood.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ninja_scroll.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_serpent.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_snake.relic.dart';

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
    default:
      relic = BurningBloodRelic();
      break;
  }

  return relic;
}

Map relicToJson(Relic relic) =>
    {...relic.toJson(), '_runtime': relic.runtimeType.toString()};
