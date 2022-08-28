import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/components/navigation_card/navigation_card.interface.dart';
import 'package:spire_mvp_flutter/components/navigation_card/navigation_card.view.dart';
import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';
import 'package:spire_mvp_flutter/enums/screens.enum.dart';

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
  navigate(BuildContext context, ScreenEnum screen) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
    if (!disabled) {
      navigation.changeScreen(screen);
    }
  }

  @override
  State<INavigationCard> createState() => NavigationCardView();
}
