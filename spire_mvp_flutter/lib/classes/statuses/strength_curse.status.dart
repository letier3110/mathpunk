import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class StrengthCurseStatus extends Status {
  StrengthCurseStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Strength Curse',
            statusDescription: "Decrease Strength by X.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.strengthCurseStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.strengthCurseStatusDescription,
      fontSize: 14,
    );
  }

  factory StrengthCurseStatus.fromJson(dynamic json) {
    return StrengthCurseStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'StrengthCurseStatus'};
}
