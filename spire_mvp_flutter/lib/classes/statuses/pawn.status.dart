import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class PawnStatus extends Status {
  PawnStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Pawn',
            statusDescription: "Upgrades random card in deck.");

  factory PawnStatus.fromJson(dynamic json) {
    return PawnStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'PawnStatus'};
}
