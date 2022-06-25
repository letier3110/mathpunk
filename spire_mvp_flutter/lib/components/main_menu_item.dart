import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';

import '../enums/screens.enum.dart';

class MainMenuItem extends StatefulWidget {
  final String text;
  final ScreenEnum? screen;

  const MainMenuItem({required this.text, this.screen, Key? key})
      : super(key: key);

  @override
  MainMenuItemState createState() {
    return MainMenuItemState();
  }
}

class MainMenuItemState extends State<MainMenuItem> {
  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

    return Container(
        width: 300,
        color: Colors.white,
        child: Stack(
          children: [
            GestureDetector(
                onTap: () {
                  if (widget.screen == ScreenEnum.quit) {
                    exit(0);
                  } else {
                    navigation
                        .changeScreen(widget.screen ?? ScreenEnum.mainMenu);
                  }
                },
                child: Container(
                  width: 300,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    widget.text,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ))
          ],
        ));
  }
}
