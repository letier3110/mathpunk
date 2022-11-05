import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class VulnerableStatus extends Status {
  VulnerableStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Vulnerable',
            statusDescription: "Target takes 50% more damage from attacks.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.vulnerableStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.vulnerableStatusDescription,
      fontSize: 14,
    );
  }

  @override
  bool isStatusPositive() => false;

  factory VulnerableStatus.fromJson(dynamic json) {
    return VulnerableStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'VulnerableStatus'};
}
