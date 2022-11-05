import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class MathMultiplierTimeStatus extends Status {
  MathMultiplierTimeStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Math Multiplier',
            statusDescription: "Multiplier for more cards.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.mathMultiplierTimeStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.mathMultiplierTimeStatusDescription,
      fontSize: 14,
    );
  }

  factory MathMultiplierTimeStatus.fromJson(dynamic json) {
    return MathMultiplierTimeStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'MathMultiplierTimeStatus'};
}
