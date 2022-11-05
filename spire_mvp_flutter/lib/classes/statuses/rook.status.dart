import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class RookStatus extends Status {
  RookStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Rook',
            statusDescription: "At the start of round, next Function cost 0.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.rookStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.rookStatusDescription,
      fontSize: 14,
    );
  }

  @override
  bool isShowStack() => false;

  factory RookStatus.fromJson(dynamic json) {
    return RookStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'RookStatus'};
}
