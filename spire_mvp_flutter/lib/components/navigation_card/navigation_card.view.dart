import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/components/navigation_card/navigation_card.interface.dart';

import '../../utils/font.util.dart';

class NavigationCardView extends State<INavigationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.navigate(context, widget.screen),
        child: Card(
          child: Container(
            width: 350,
            height: 600,
            color: widget.disabled ? Colors.redAccent : Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(
                    widget.heading,
                    style: TextStyle(fontSize: getFontSize(34)),
                  ),
                ),
                Text(
                  "img.png",
                  style: TextStyle(fontSize: getFontSize(16)),
                  // color: Colors.amber
                ),
                const Spacer(flex: 1),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.description,
                    style: TextStyle(fontSize: getFontSize(20)),
                    textAlign: TextAlign.center,
                    // color: Colors.amber
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ));
  }
}
