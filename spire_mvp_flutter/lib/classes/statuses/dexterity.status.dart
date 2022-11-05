import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class DexterityStatus extends Status {
  DexterityStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Dexterity',
            statusDescription: "Increases block by X.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.dexterityStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.dexterityStatusDescription,
      fontSize: 14,
    );
  }

  factory DexterityStatus.fromJson(dynamic json) {
    return DexterityStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'DexterityStatus'};
}
