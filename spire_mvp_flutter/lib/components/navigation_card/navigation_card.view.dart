import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/components/navigation_card/navigation_card.interface.dart';

AssetImage pickImage(bool disabled) {
  if (disabled) {
    return const AssetImage('assets/mode_bg_disabled.png');
  }
  return const AssetImage('assets/mode_bg.png');
}

class NavigationCardView extends State<INavigationCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => widget.navigate(context, widget.screen),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: pickImage(widget.disabled), fit: BoxFit.fill),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(48, 40, 48, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(
                    widget.heading,
                    style: const TextStyle(fontSize: 34),
                  ),
                ),
                const Text(
                  "img.png",
                  style: TextStyle(fontSize: 16),
                  // color: Colors.amber
                ),
                const Spacer(flex: 1),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.description,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                    // color: Colors.amber
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
