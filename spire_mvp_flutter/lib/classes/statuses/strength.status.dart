import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class StrengthStatus extends Status {
  StrengthStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Strength',
            statusDescription: "Increases attack damage by X (per hit).");

  factory StrengthStatus.fromJson(dynamic json) {
    return StrengthStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'StrengthStatus'};
}
