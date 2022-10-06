import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class DexterityEmpowerStatus extends Status {
  DexterityEmpowerStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Dexterity Empower',
            statusDescription: "Decrease Dexterity by X.");

  factory DexterityEmpowerStatus.fromJson(dynamic json) {
    return DexterityEmpowerStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'DexterityEmpowerStatus'};
}
