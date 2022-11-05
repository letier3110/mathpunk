import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class DexterityCurseStatus extends Status {
  DexterityCurseStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Dexterity Curse',
            statusDescription: "Decrease Dexterity by X.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.dexterityCurseStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.dexterityCurseStatusDescription,
      fontSize: 14,
    );
  }

  factory DexterityCurseStatus.fromJson(dynamic json) {
    return DexterityCurseStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'DexterityCurseStatus'};
}
