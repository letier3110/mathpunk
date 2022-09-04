import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/utils/font.util.dart';

class TraderPawnView extends StatefulWidget {
  final Function callback;
  const TraderPawnView({required this.callback, Key? key}) : super(key: key);

  @override
  State<TraderPawnView> createState() => TraderPawnViewView();
}

class TraderPawnViewView extends State<TraderPawnView> {
  @override
  Widget build(BuildContext context) {
    void onTapHandler() {
      widget.callback();
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTapHandler,
      child: Stack(children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            height: width / 3,
            width: width / 3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/shopkeeper.jpeg'),
                  fit: BoxFit.fill),
            ),
          ),
        ),
        Center(
          child: Container(
            height: width / 3,
            margin: EdgeInsets.fromLTRB(0, height - 120, 0, 0),
            child: Text(
              "Shopkeeper",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getFontSize(22),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }
}
