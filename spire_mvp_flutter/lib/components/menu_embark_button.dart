import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';

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
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

    return Positioned(
      bottom: 0,
      right: 20,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          height: 80,
          alignment: Alignment.bottomLeft,
          width: 100,
          // decoration: BoxDecoration(
          //     color: Colors.red, borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            children: [
              GestureDetector(
                  onTap: () => {
                        gameState.startGame(),
                        navigation.changeScreen(ScreenEnum.game)
                      },
                  child: Positioned(
                    top: 120,
                    child: Column(children: [
                      Container(
                          width: 300,
                          height: 50,
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Embark',
                              style: TextStyle(fontSize: 24.0),
                            ),
                          )),
                    ]),
                  )),
            ],
          )),
    );
  }
}
