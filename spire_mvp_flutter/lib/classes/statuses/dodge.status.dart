import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class DodgeStatus extends Status {
  DodgeStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Dodge',
            statusDescription: "Prevents taking damage.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.dodgeStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.dodgeStatusDescription,
      fontSize: 14,
    );
  }

  factory DodgeStatus.fromJson(dynamic json) {
    return DodgeStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'DodgeStatus'};
}
