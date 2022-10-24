import 'package:mathpunk_cardgame/classes/statuses/status.dart';

class VulnerableStatus extends Status {
  VulnerableStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Vulnerable',
            statusDescription: "Target takes 50% more damage from attacks.");

  factory VulnerableStatus.fromJson(dynamic json) {
    return VulnerableStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'VulnerableStatus'};
}
