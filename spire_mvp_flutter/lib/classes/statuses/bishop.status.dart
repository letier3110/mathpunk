import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class BishopStatus extends Status {
  BishopStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Bishop',
            statusDescription: "Cards can be played for free, if costs 1.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.bishopStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.bishopStatusDescription,
      fontSize: 14,
    );
  }

  @override
  bool isShowStack() => false;

  factory BishopStatus.fromJson(dynamic json) {
    return BishopStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'BishopStatus'};
}
