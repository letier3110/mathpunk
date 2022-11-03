import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameForwardButton extends StatefulWidget {
  final Function goForward;

  const GameForwardButton({required this.goForward, Key? key})
      : super(key: key);

  @override
  State<GameForwardButton> createState() => _GameForwardButtonState();
}

class _GameForwardButtonState extends State<GameForwardButton> {
  @override
  Widget build(BuildContext context) {
    void onTapHandler() {
      widget.goForward();
    }

    return Positioned(
      bottom: 0,
      right: 20,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          height: 80,
          alignment: Alignment.bottomLeft,
          width: 100,
          child: Stack(
            children: [
              GestureDetector(
                  onTap: onTapHandler,
                  child: Positioned(
                    top: 120,
                    child: Column(children: [
                      Container(
                          width: 300,
                          height: 50,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.proceedText,
                              style: const TextStyle(fontSize: 22),
                            ),
                          )),
                    ]),
                  )),
            ],
          )),
    );
  }
}
