import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class WeakStatus extends Status {
  WeakStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Weak',
            statusDescription: "Target deals 25% less attack damage.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.weakStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.weakStatusDescription,
      fontSize: 14,
    );
  }

  @override
  bool isStatusPositive() => false;

  factory WeakStatus.fromJson(dynamic json) {
    return WeakStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'WeakStatus'};
}
