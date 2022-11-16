import 'package:flutter/material.dart';

class CardMana extends StatelessWidget {
  final int cardMana;
  final int currentMana;
  const CardMana({this.cardMana = 1, this.currentMana = 1, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      cardMana.toString(),
      style: TextStyle(
          color: currentMana < cardMana
              ? Colors.greenAccent
              : currentMana > cardMana
                  ? Colors.redAccent
                  : Colors.white,
          fontSize: 14),
    );
  }
}
