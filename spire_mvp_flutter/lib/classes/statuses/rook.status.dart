import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class RookStatus extends Status {
  RookStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Rook',
            statusDescription: "At the start of round, next Function cost 0.");

  factory RookStatus.fromJson(dynamic json) {
    return RookStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'RookStatus'};
}
