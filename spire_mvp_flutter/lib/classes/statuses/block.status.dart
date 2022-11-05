import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class BlockStatus extends Status {
  BlockStatus()
      : super(
            asset: 'assets/relics/chess_pyramid.png',
            statusName: 'Block',
            statusDescription: "Until next turn, prevents damage.");

  @override
  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.blockStatusName,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: AppLocalizations.of(context)!.blockStatusDescription,
      fontSize: 14,
    );
  }

  factory BlockStatus.fromJson(dynamic json) {
    return BlockStatus();
  }

  @override
  Map toJson() => {...super.toJson(), '_runtime': 'BlockStatus'};
}
