import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/components/navigation_card/navigation_card.view.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class INavigationCard extends ConsumerStatefulWidget {
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

  navigate(BuildContext context, WidgetRef ref, ScreenEnum screen) {
    final navigation = ref.watch(navigationProvider.notifier);
    if (!disabled) {
      navigation.changeScreen(screen);
    }
  }

  @override
  ConsumerState<INavigationCard> createState() => NavigationCardView();
}
