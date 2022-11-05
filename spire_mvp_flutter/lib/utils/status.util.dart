import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/king.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/knight.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_time.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/pawn.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/queen.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/rook.status.dart';
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
    case KingStatus:
      return SizedBox(
          width: 16,
          height: 16,
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SvgPicture.asset(
                'assets/chess/king.svg',
                color: Colors.white,
                matchTextDirection: true,
              ),
            ),
          ));
    case QueenStatus:
      return SizedBox(
          width: 16,
          height: 16,
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SvgPicture.asset(
                'assets/chess/queen.svg',
                color: Colors.white,
                matchTextDirection: true,
              ),
            ),
          ));
    case BishopStatus:
      return SizedBox(
          width: 16,
          height: 16,
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SvgPicture.asset(
                'assets/chess/bishop.svg',
                color: Colors.white,
                matchTextDirection: true,
              ),
            ),
          ));
    case KnightStatus:
      return SizedBox(
          width: 16,
          height: 16,
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SvgPicture.asset(
                'assets/chess/knight.svg',
                color: Colors.white,
                matchTextDirection: true,
              ),
            ),
          ));
    case RookStatus:
      return SizedBox(
          width: 16,
          height: 16,
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SvgPicture.asset(
                'assets/chess/rook.svg',
                color: Colors.white,
                matchTextDirection: true,
              ),
            ),
          ));
    case PawnStatus:
      return SizedBox(
          width: 16,
          height: 16,
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SvgPicture.asset(
                'assets/chess/pawn.svg',
                color: Colors.white,
                matchTextDirection: true,
              ),
            ),
          ));
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
