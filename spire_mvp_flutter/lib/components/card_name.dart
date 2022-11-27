import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/util.dart';

class CardName extends StatefulWidget {
  final bool isUpgraded;
  final String name;
  const CardName({this.isUpgraded = false, this.name = 'unset', Key? key})
      : super(key: key);

  @override
  State<CardName> createState() {
    return CardNameState();
  }
}

class CardNameState extends State<CardName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.name,
      style: TextStyle(
          color: widget.isUpgraded ? getUpgradedCardColor() : Colors.white,
          fontSize: 16),
    );
  }
}
