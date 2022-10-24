import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class DexterityCurseStatus extends Status {
  DexterityCurseStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Dexterity Curse',
            statusDescription: "Decrease Dexterity by X.");

  factory DexterityCurseStatus.fromJson(dynamic json) {
    return DexterityCurseStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'DexterityCurseStatus'};
}
