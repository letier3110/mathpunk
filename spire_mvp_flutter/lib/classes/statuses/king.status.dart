import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class KingStatus extends Status {
  KingStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'King',
            statusDescription: "Rewards doubled for this encounter.");

  factory KingStatus.fromJson(dynamic json) {
    return KingStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'KingStatus'};
}
