import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';

class PrecisionStatus extends Status {
  PrecisionStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Precision',
            statusDescription: "Chance to do damage.",
            statusStack: maxPrecisionChance);

  factory PrecisionStatus.fromJson(dynamic json) {
    return PrecisionStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'PrecisionStatus'};
}
