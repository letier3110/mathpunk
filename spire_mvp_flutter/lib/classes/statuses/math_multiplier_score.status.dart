import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class MathMultiplierScoreStatus extends Status {
  MathMultiplierScoreStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Multiplier',
            statusDescription: "Multiplies next attack.");

  @override
  bool isShowStatus() => false;

  factory MathMultiplierScoreStatus.fromJson(dynamic json) {
    return MathMultiplierScoreStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'MathMultiplierScoreStatus'};
}
