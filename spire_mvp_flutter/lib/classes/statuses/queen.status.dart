import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class QueenStatus extends Status {
  QueenStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Queen',
            statusDescription:
                "Improves your stats: adds 2 strength, 2 dexterity and 15% precision.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.queenStatusName,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.queenStatusDescription,
      fontSize: 14,
    );
  }

  @override
  bool isShowStack() => false;

  factory QueenStatus.fromJson(dynamic json) {
    return QueenStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'QueenStatus'};
}
