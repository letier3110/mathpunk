import 'package:flutter/material.dart';

import '../components/main_menu_item.dart';
import '../enums/screens.enum.dart';

class MenuBackButton extends StatefulWidget {
  late ScreenEnum? backScreen;

  MenuBackButton({this.backScreen, Key? key}) : super(key: key);

  @override
  State<MenuBackButton> createState() => _MenuBackButtonState();
}

class _MenuBackButtonState extends State<MenuBackButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          height: 200,
          alignment: Alignment.bottomLeft,
          width: 300,
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
