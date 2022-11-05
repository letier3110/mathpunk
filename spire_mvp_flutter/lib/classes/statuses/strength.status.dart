import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class StrengthStatus extends Status {
  StrengthStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Strength',
            statusDescription: "Increases attack damage by X (per hit).");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.strengthStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.strengthStatusDescription,
      fontSize: 14,
    );
  }

  factory StrengthStatus.fromJson(dynamic json) {
    return StrengthStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'StrengthStatus'};
}
