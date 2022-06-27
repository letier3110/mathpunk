import 'package:flutter/material.dart';

import '../components/main_menu_item.dart';
import '../enums/screens.enum.dart';

class MenuEmbarkButton extends StatefulWidget {
  const MenuEmbarkButton({Key? key}) : super(key: key);

  @override
  State<MenuEmbarkButton> createState() => _MenuEmbarkButtonState();
}

class _MenuEmbarkButtonState extends State<MenuEmbarkButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 20,
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
                child: Column(children: const [
                  MainMenuItem(
                    text: 'Embark',
                    screen: ScreenEnum.game,
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
