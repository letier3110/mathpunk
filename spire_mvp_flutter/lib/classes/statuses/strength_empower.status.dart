import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class StrengthEmpowerStatus extends Status {
  StrengthEmpowerStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Strength Empower',
            statusDescription: "Increases Strength by X.");

  factory StrengthEmpowerStatus.fromJson(dynamic json) {
    return StrengthEmpowerStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'StrengthEmpowerStatus'};
}
