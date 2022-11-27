import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity_curse.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity_empower.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dodge.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/king.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/knight.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_time.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/pawn.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/precision.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/queen.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/rook.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength_curse.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength_empower.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/vulnerable.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/weak.status.dart';

import '../classes/statuses/bishop.status.dart';

Status statusFromJson(dynamic json) {
  double jsonStatusStack = double.parse(json['stack']);

  String jsonRuntime = json['_runtime'] as String;

  Status status;

  switch (jsonRuntime) {
    case 'BlockStatus':
      status = BlockStatus();
      break;
    case 'BishopStatus':
      status = BishopStatus();
      break;
    case 'DexterityCurseStatus':
      status = DexterityCurseStatus();
      break;
    case 'DexterityEmpowerStatus':
      status = DexterityEmpowerStatus();
      break;
    case 'DexterityStatus':
      status = DexterityStatus();
      break;
    case 'DodgeStatus':
      status = DodgeStatus();
      break;
    case 'KingStatus':
      status = KingStatus();
      break;
    case 'KnightStatus':
      status = KnightStatus();
      break;
    case 'MathMultiplierScoreStatus':
      status = MathMultiplierScoreStatus();
      break;
    case 'MathMultiplierTimeStatus':
      status = MathMultiplierTimeStatus();
      break;
    case 'PawnStatus':
      status = PawnStatus();
      break;
    case 'PrecisionStatus':
      status = PrecisionStatus();
      break;
    case 'QueenStatus':
      status = QueenStatus();
      break;
    case 'RookStatus':
      status = RookStatus();
      break;
    case 'StrengthCurseStatus':
      status = StrengthCurseStatus();
      break;
    case 'StrengthEmpowerStatus':
      status = StrengthEmpowerStatus();
      break;
    case 'StrengthStatus':
      status = StrengthStatus();
      break;
    case 'VulnerableStatus':
      status = VulnerableStatus();
      break;
    default:
      status = WeakStatus();
      break;
  }

  status.addStack(jsonStatusStack);

  return status;
}

Map statusToJson(Status status) =>
    {...status.toJson(), '_runtime': status.runtimeType.toString()};
