import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_time.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/weak.status.dart';

Widget getStatusIcon(Status status) {
  switch (status.runtimeType) {
    case BlockStatus:
      return const Icon(
        Icons.shield,
        size: 16.0,
        color: Colors.white,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    case MathMultiplierTimeStatus:
      return const Icon(
        Icons.stacked_bar_chart,
        size: 16.0,
        color: Colors.white,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    case WeakStatus:
      return const Icon(
        Icons.sports_gymnastics,
        size: 16.0,
        color: Colors.white,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    case StrengthStatus:
      return const Icon(
        Icons.sports_kabaddi,
        size: 16.0,
        color: Colors.white,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    case DexterityStatus:
      return const Icon(
        Icons.sports_gymnastics,
        size: 16.0,
        color: Colors.white,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    // case EventRoom:
    // case MindBloomEventRoom:
    //   return const Icon(
    //     Icons.question_mark,
    //     size: 16.0,
    //     semanticLabel: 'Text to announce in accessibility modes',
    //   );
    default:
      return const Icon(
        Icons.smart_toy,
        size: 16.0,
        color: Colors.white,
        semanticLabel: 'Text to announce in accessibility modes',
      );
  }
}
