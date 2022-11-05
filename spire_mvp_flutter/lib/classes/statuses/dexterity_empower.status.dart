import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class DexterityEmpowerStatus extends Status {
  DexterityEmpowerStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Dexterity Empower',
            statusDescription: "Increases Dexterity by X.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.dexterityEmpowerStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.dexterityEmpowerStatusDescription,
      fontSize: 14,
    );
  }

  factory DexterityEmpowerStatus.fromJson(dynamic json) {
    return DexterityEmpowerStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'DexterityEmpowerStatus'};
}
