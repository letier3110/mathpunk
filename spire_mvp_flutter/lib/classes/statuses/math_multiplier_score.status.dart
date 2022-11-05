import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class MathMultiplierScoreStatus extends Status {
  MathMultiplierScoreStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Math Multiplier',
            statusDescription: "Multiplies next attack.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.mathMultiplierScoreStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.mathMultiplierScoreStatusDescription,
      fontSize: 14,
    );
  }

  @override
  bool isShowStatus() => false;

  factory MathMultiplierScoreStatus.fromJson(dynamic json) {
    return MathMultiplierScoreStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'MathMultiplierScoreStatus'};
}
