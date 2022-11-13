import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ArmamentsCardName extends StatefulWidget {
  const ArmamentsCardName({Key? key}) : super(key: key);

  @override
  State<ArmamentsCardName> createState() {
    return ArmamentsCardNameState();
  }
}

class ArmamentsCardNameState extends State<ArmamentsCardName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.armamentsCardName,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
