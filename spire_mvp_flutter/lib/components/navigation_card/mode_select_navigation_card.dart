import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/components/navigation_card/navigation_card.interface.dart';
import 'package:mathpunk_cardgame/components/navigation_card/navigation_card.view.dart';
import 'package:mathpunk_cardgame/controllers/gamemode.provider.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
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
  navigate(BuildContext context, WidgetRef ref, ScreenEnum screen) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    final gamemodeNotifier = ref.read(gamemodeProvider.notifier);
    if (!disabled) {
      navigationNotifier.changeScreen(screen);
      gamemodeNotifier.changeGameMode(gameType);
    }
  }

  @override
  ConsumerState<INavigationCard> createState() => NavigationCardView();
}
