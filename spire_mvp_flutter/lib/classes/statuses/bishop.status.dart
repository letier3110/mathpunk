import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class BishopStatus extends Status {
  BishopStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Bishop',
            statusDescription: "Cards can be played for free, if costs 1.");

  factory BishopStatus.fromJson(dynamic json) {
    return BishopStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'BishopStatus'};
}
