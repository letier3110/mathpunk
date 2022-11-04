// import 'dart:ui';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/controllers/navigation.controller.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

class MainSettingsScreen extends StatefulWidget {
  const MainSettingsScreen({Key? key}) : super(key: key);

  @override
  State<MainSettingsScreen> createState() => _MainSettingsScreenState();
}

class _MainSettingsScreenState extends State<MainSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
//     var pixelRatio = window.devicePixelRatio;

//     //Size in physical pixels
//     var physicalScreenSize = window.physicalSize;
//     var physicalWidth = physicalScreenSize.width;
//     var physicalHeight = physicalScreenSize.height;

// //Size in logical pixels
//     var logicalScreenSize = window.physicalSize / pixelRatio;
//     var logicalWidth = logicalScreenSize.width;
//     var logicalHeight = logicalScreenSize.height;

// //Padding in physical pixels
//     var padding = window.padding;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print('$width x $height');
    void onTap1280() {
      setWindowMinSize(const Size(1280, 720));
      navigation.changeScreen(ScreenEnum.mainMenu);
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
            ),
          ),
          Center(
              child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 160.0),
            child: Text(
              AppLocalizations.of(context)!.settings,
              style: const TextStyle(fontSize: 34, color: Colors.black),
            ),
          )),
          Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onTap1280,
                    child: Container(
                        width: 300,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/menu_bg_2.png'),
                              fit: BoxFit.fill),
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
                                '$width x $height',
                                style: const TextStyle(
                                    fontSize: 34, color: Colors.black),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
