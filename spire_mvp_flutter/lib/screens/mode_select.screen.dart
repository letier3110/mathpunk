import 'package:flutter/material.dart';

import '../components/main_menu_item.dart';
import '../enums/screens.enum.dart';

class ModeSelectScreen extends StatefulWidget {
  const ModeSelectScreen({Key? key}) : super(key: key);

  @override
  State<ModeSelectScreen> createState() => _ModeSelectScreenState();
}

class _ModeSelectScreenState extends State<ModeSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Center(
              child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 160.0),
            child: Text(
              "Mode Select",
              style: Theme.of(context).textTheme.headline4,
            ),
          )),
          Positioned(
            bottom: 0,
            child: Container(
                margin: const EdgeInsets.all(8.0),
                height: 500,
                alignment: Alignment.bottomLeft,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 120,
                      child: Column(children: const [
                        MainMenuItem(
                          text: 'Back',
                          screen: ScreenEnum.mainMenu,
                        ),
                      ]),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
