import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/components/navigation_card/navigation_card.interface.dart';

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
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Text(
                  "img.png",
                  style: Theme.of(context).textTheme.bodyLarge,
                  // color: Colors.amber
                ),
                const Spacer(flex: 1),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.description,
                    style: Theme.of(context).textTheme.headline6,
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
