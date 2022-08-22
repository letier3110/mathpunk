import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/components/navigation_card/mode_select_navigation_card.dart';
import 'package:spire_mvp_flutter/enums/game_type.enum.dart';

import '../components/menu_back_button.dart';
import '../enums/screens.enum.dart';

class ModeSelectScreen extends StatefulWidget {
  const ModeSelectScreen({Key? key}) : super(key: key);

  @override
  State<ModeSelectScreen> createState() => _ModeSelectScreenState();
}

class _ModeSelectScreenState extends State<ModeSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
          )),
          Center(
            // color: Colors.blue,
            child: Container(
              padding: const EdgeInsets.all(40),
              constraints: const BoxConstraints(
                minHeight: 255.0,
                maxHeight: 830.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Spacer(
                    flex: 2,
                  ),
                  ModeSelectNavigationCard(
                    heading: 'Standard',
                    description:
                        "Standard mode is the default mode. It is the most common mode for players.",
                    screen: ScreenEnum.characterSelect,
                    gameType: GameTypeEnum.standard,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  ModeSelectNavigationCard(
                    heading: 'Daily Climb',
                    description:
                        "Daily Climb mode is a mode for players who want to climb more often.",
                    screen: ScreenEnum.characterSelect,
                    gameType: GameTypeEnum.daily,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  ModeSelectNavigationCard(
                    heading: 'Custom',
                    description:
                        "Custom mode is a mode for players who want to create their own climb.",
                    screen: ScreenEnum.characterSelect,
                    gameType: GameTypeEnum.custom,
                    disabled: true,
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
          const MenuBackButton(
            backScreen: ScreenEnum.mainMenu,
          ),
        ],
      ),
    );
  }
}
