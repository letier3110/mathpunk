import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/components/navigation_card/mode_select_navigation_card.dart';
import 'package:mathpunk_cardgame/enums/game_type.enum.dart';

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
    double height = MediaQuery.of(context).size.height;

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
              margin: const EdgeInsets.all(120),
              constraints: const BoxConstraints(
                minHeight: 300,
                maxHeight: 800,
              ),
              height: height / 1.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ModeSelectNavigationCard(
                    heading: AppLocalizations.of(context)!.standardModeName,
                    description:
                        AppLocalizations.of(context)!.standardModeDescription,
                    screen: ScreenEnum.characterSelect,
                    gameType: GameTypeEnum.standard,
                  ),
                  ModeSelectNavigationCard(
                    heading: AppLocalizations.of(context)!.dailyModeName,
                    description:
                        AppLocalizations.of(context)!.dailyModeDescription,
                    screen: ScreenEnum.characterSelect,
                    gameType: GameTypeEnum.daily,
                  ),
                  ModeSelectNavigationCard(
                    heading: AppLocalizations.of(context)!.customModeName,
                    description:
                        AppLocalizations.of(context)!.customModeDescription,
                    screen: ScreenEnum.characterSelect,
                    gameType: GameTypeEnum.custom,
                    disabled: true,
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
