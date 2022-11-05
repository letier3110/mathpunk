import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class PrecisionStatus extends Status {
  PrecisionStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Precision',
            statusDescription: "Chance to do damage.",
            statusStack: maxPrecisionChance);

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.precisionStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.precisionStatusDescription,
      fontSize: 14,
    );
  }

  factory PrecisionStatus.fromJson(dynamic json) {
    return PrecisionStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'PrecisionStatus'};
}
