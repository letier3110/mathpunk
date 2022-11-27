import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/util.dart';

class AngerUpgradeCardName extends StatefulWidget {
  const AngerUpgradeCardName({Key? key}) : super(key: key);

  @override
  State<AngerUpgradeCardName> createState() {
    return AngerUpgradeCardNameState();
  }
}

class AngerUpgradeCardNameState extends State<AngerUpgradeCardName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.angerCardUpgradeName,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }
}
