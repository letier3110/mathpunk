import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/components/navigation_card/navigation_card.interface.dart';
import 'package:mathpunk_cardgame/components/navigation_card/navigation_card.view.dart';
import 'package:mathpunk_cardgame/controllers/gamestate/gamestate.controller.dart';
import 'package:mathpunk_cardgame/controllers/navigation.controller.dart';
import 'package:mathpunk_cardgame/enums/game_type.enum.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class ModeSelectNavigationCard extends INavigationCard {
  final GameTypeEnum gameType;

  const ModeSelectNavigationCard(
      {required heading,
      required description,
      required screen,
      required this.gameType,
      disabled = false,
      Key? key})
      : super(
            heading: heading,
            description: description,
            screen: screen,
            disabled: disabled,
            key: key);

  @override
  navigate(BuildContext context, ScreenEnum screen) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);
    if (!disabled) {
      navigation.changeScreen(screen);
      gameState.changeGameMode(gameType);
    }
  }

  @override
  State<INavigationCard> createState() => NavigationCardView();
}
