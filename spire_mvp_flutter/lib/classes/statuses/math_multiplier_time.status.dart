import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class MathMultiplierTimeStatus extends Status {
  MathMultiplierTimeStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Multiplier',
            statusDescription: "Multiplier for more cards.");

  factory MathMultiplierTimeStatus.fromJson(dynamic json) {
    return MathMultiplierTimeStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'MathMultiplierTimeStatus'};
}
