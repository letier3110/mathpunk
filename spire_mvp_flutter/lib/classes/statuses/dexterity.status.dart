import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class DexterityStatus extends Status {
  DexterityStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Dexterity',
            statusDescription: "Increases block by X.");

  factory DexterityStatus.fromJson(dynamic json) {
    return DexterityStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'DexterityStatus'};
}
