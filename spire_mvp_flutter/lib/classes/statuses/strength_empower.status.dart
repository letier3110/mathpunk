import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class StrengthEmpowerStatus extends Status {
  StrengthEmpowerStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Strength Empower',
            statusDescription: "Increases Strength by X.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.strengthEmpowerStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.strengthEmpowerStatusDescription,
      fontSize: 14,
    );
  }

  factory StrengthEmpowerStatus.fromJson(dynamic json) {
    return StrengthEmpowerStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'StrengthEmpowerStatus'};
}
