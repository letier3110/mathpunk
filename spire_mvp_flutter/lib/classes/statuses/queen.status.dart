import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class QueenStatus extends Status {
  QueenStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Queen',
            statusDescription:
                "Improves your stats: adds 2 strength, 2 dexterity, 15% precision and 1 draw power.");

  factory QueenStatus.fromJson(dynamic json) {
    return QueenStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'QueenStatus'};
}
