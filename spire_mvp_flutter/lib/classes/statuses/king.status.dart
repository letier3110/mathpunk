import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class KingStatus extends Status {
  KingStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'King',
            statusDescription: "Rewards doubled for this encounter.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.kingStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.kingStatusDescription,
      fontSize: 14,
    );
  }

  @override
  bool isShowStack() => false;

  factory KingStatus.fromJson(dynamic json) {
    return KingStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'KingStatus'};
}
