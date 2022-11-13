import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/util.dart';

class ArmamentsUpgradeCardName extends StatefulWidget {
  const ArmamentsUpgradeCardName({Key? key}) : super(key: key);

  @override
  State<ArmamentsUpgradeCardName> createState() {
    return ArmamentsUpgradeCardNameState();
  }
}

class ArmamentsUpgradeCardNameState extends State<ArmamentsUpgradeCardName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.armamentsCardName,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }
}
