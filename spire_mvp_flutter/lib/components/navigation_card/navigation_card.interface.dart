import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/components/navigation_card/navigation_card.view.dart';
import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';
import 'package:spire_mvp_flutter/enums/screens.enum.dart';

class INavigationCard extends StatefulWidget {
  final String heading;
  final String description;
  final bool disabled;
  final ScreenEnum screen;

  const INavigationCard(
      {required this.heading,
      required this.description,
      required this.screen,
      this.disabled = false,
      Key? key})
      : super(key: key);

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
