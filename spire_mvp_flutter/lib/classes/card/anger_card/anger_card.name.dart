import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AngerCardName extends StatefulWidget {
  const AngerCardName({Key? key}) : super(key: key);

  @override
  State<AngerCardName> createState() {
    return AngerCardNameState();
  }
}

class AngerCardNameState extends State<AngerCardName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.angerCardName,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
