import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class KnightStatus extends Status {
  KnightStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Knight',
            statusDescription: "At the start of round, get random card.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.knightStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.knightStatusDescription,
      fontSize: 14,
    );
  }

  @override
  bool isShowStack() => false;

  factory KnightStatus.fromJson(dynamic json) {
    return KnightStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'KnightStatus'};
}
