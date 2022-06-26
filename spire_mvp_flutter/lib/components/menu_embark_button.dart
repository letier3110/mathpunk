import 'package:flutter/material.dart';

import '../components/main_menu_item.dart';
import '../enums/screens.enum.dart';

class MenuEmbarkButton extends StatefulWidget {
  final ScreenEnum? backScreen;

  const MenuEmbarkButton({this.backScreen, Key? key}) : super(key: key);

  @override
  State<MenuEmbarkButton> createState() => _MenuEmbarkButtonState();
}

class _MenuEmbarkButtonState extends State<MenuEmbarkButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          height: 200,
          alignment: Alignment.bottomLeft,
          width: 100,
          // decoration: BoxDecoration(
          //     color: Colors.red, borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            children: [
              Positioned(
                top: 120,
                child: Column(children: [
                  MainMenuItem(
                    text: 'Back',
                    screen: widget.backScreen ?? ScreenEnum.mainMenu,
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
