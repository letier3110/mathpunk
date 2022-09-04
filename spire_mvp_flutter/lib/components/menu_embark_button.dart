import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';
import 'package:mathpunk_cardgame/controllers/navigation.controller.dart';
import 'package:mathpunk_cardgame/utils/font.util.dart';

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
      child: Stack(
        children: [
          GestureDetector(
              onTap: () => {
                    gameState.startGame(),
                    navigation.changeScreen(ScreenEnum.game)
                  },
              child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 32),
                  width: 120,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/menu_bg_2.png'),
                        fit: BoxFit.fill),
                  ),
                  child: const Center(
                    child: Text(
                      'Embark',
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ))),
        ],
      ),
    );
  }
}
