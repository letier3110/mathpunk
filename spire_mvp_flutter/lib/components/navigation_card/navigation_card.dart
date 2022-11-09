import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/components/navigation_card/navigation_card.interface.dart';
import 'package:mathpunk_cardgame/components/navigation_card/navigation_card.view.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class NavigationCard extends INavigationCard {
  const NavigationCard(
      {required heading,
      required description,
      required screen,
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
    final navigation = ref.read(navigationProvider.notifier);
    if (!disabled) {
      navigation.changeScreen(screen);
    }
  }

  @override
  ConsumerState<INavigationCard> createState() => NavigationCardView();
}
