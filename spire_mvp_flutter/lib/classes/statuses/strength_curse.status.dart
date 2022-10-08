import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class StrengthCurseStatus extends Status {
  StrengthCurseStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Strength Empower',
            statusDescription: "Decrease Strength by X.");

  factory StrengthCurseStatus.fromJson(dynamic json) {
    return StrengthCurseStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'StrengthCurseStatus'};
}
