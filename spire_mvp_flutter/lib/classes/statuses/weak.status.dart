import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class WeakStatus extends Status {
  WeakStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Weak',
            statusDescription: "Target deals 25% less attack damage.");

  factory WeakStatus.fromJson(dynamic json) {
    return WeakStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'WeakStatus'};
}
