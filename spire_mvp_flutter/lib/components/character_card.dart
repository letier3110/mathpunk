import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/components/navigation_card/navigation_card.view.dart';
import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';
import 'package:spire_mvp_flutter/enums/screens.enum.dart';

class CharacterCard extends StatefulWidget {
  final String heading;
  final String description;
  final String img;
  final bool disabled;

  const CharacterCard(
      {required this.heading,
      required this.description,
      required this.img,
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
  State<CharacterCard> createState() => CharacterCardView();
}

class CharacterCardView extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap: () => widget.navigate(context, widget.screen),
        child: Card(
      child: Container(
        width: 120,
        height: 120,
        color: widget.disabled ? Colors.red : Colors.amber,
        child: Center(
          child: Text(
            widget.img,
            style: Theme.of(context).textTheme.bodyLarge,
            // color: Colors.amber
          ),
        ),
      ),
    ));
  }
}
