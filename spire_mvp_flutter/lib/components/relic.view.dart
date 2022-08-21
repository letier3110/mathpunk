import 'package:flutter/material.dart';

import 'package:spire_mvp_flutter/classes/relic/relic.dart';

import 'package:spire_mvp_flutter/utils/font.util.dart';

class RelicView extends StatefulWidget {
  final Relic relic;
  final Function? onTap;
  final bool disabled;
  const RelicView(
      {required this.relic, this.onTap, this.disabled = false, Key? key})
      : super(key: key);

  @override
  State<RelicView> createState() => RelicViewView();
}

class RelicViewView extends State<RelicView> {
  @override
  Widget build(BuildContext context) {
    void onTapHandler() {
      if (widget.disabled) {
        return;
      }
      if (widget.onTap != null) {
        widget.onTap!();
        return;
      }
    }

    return SizedBox(
      width: 120,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Icon(
                Icons.sports_mma,
                color: Colors.greenAccent,
              ),
            ),
            Text(
              widget.relic.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: getFontSize(12),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}