import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

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

    void onTapHandler() {
      if (widget.screen == ScreenEnum.quit) {
        exit(0);
      } else if (widget.screen != null) {
        navigation.changeScreen(widget.screen ?? ScreenEnum.mainMenu);
      }
    }

    return GestureDetector(
      onTap: onTapHandler,
      child: Container(
          width: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/menu_bg_2.png'), fit: BoxFit.fill),
          ),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 50.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: getFontSize(22)),
                ),
              )
            ],
          )),
    );
  }
}
