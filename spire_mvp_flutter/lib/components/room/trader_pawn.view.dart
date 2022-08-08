import 'package:flutter/material.dart';

import 'package:spire_mvp_flutter/utils/font.util.dart';

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

    return Positioned(
      top: 100,
      right: 220,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 300,
            width: 300,
            child: Center(
              child: Text(
                "Shl'don trader",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getFontSize(22),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
