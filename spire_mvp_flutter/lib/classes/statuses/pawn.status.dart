import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class PawnStatus extends Status {
  PawnStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Pawn',
            statusDescription: "Upgrades random card in deck.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.pawnStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.pawnStatusDescription,
      fontSize: 14,
    );
  }

  @override
  bool isShowStack() => false;

  factory PawnStatus.fromJson(dynamic json) {
    return PawnStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'PawnStatus'};
}
