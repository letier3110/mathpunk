import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class DodgeStatus extends Status {
  DodgeStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Dodge',
            statusDescription: "Prevents taking damage.");

  factory DodgeStatus.fromJson(dynamic json) {
    return DodgeStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'DodgeStatus'};
}
