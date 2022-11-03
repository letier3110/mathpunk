import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/relic/relic.dart';

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
              width: 48,
              height: 48,
              padding: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.relic.getAssetImage()),
                    fit: BoxFit.fill),
              ),
            ),
            Text(
              widget.relic.getNameTranslationKey(context),
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
