import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class BlockStatus extends Status {
  BlockStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Block',
            statusDescription: "Until next turn, prevents damage.");

  factory BlockStatus.fromJson(dynamic json) {
    return BlockStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'BlockStatus'};
}
