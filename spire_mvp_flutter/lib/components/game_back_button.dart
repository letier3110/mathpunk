import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class GameBackButton extends StatefulWidget {
  final Function goBack;

  const GameBackButton({required this.goBack, Key? key}) : super(key: key);

  @override
  State<GameBackButton> createState() => _GameBackButtonState();
}

class _GameBackButtonState extends State<GameBackButton> {
  @override
  Widget build(BuildContext context) {
    void onTapHandler() {
      widget.goBack();
    }

    return Positioned(
      bottom: 0,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          height: 200,
          alignment: Alignment.bottomLeft,
          width: 100,
          child: Stack(
            children: [
              Positioned(
                top: 120,
                child: Column(children: [
                  Container(
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/menu_bg_2.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Stack(
                        children: [
                          GestureDetector(
                              onTap: onTapHandler,
                              child: Container(
                                width: 300,
                                height: 50.0,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text(
                                  'Leave',
                                  style: TextStyle(fontSize: getFontSize(22)),
                                ),
                              ))
                        ],
                      )),
                ]),
              ),
            ],
          )),
    );
  }
}
