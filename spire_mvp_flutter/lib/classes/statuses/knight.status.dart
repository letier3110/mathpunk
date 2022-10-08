import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class KnightStatus extends Status {
  KnightStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Knight',
            statusDescription: "At the start of round, get random card.");

  factory KnightStatus.fromJson(dynamic json) {
    return KnightStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'KnightStatus'};
}
