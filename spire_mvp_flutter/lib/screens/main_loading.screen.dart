import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';
import 'package:mathpunk_cardgame/controllers/navigation.controller.dart';
import 'package:mathpunk_cardgame/controllers/saves.controller.dart';

import '../utils/font.util.dart';

class MainLoadingScreen extends StatefulWidget {
  const MainLoadingScreen({Key? key}) : super(key: key);

  @override
  State<MainLoadingScreen> createState() => _MainLoadingScreenState();
}

class _MainLoadingScreenState extends State<MainLoadingScreen> {
  @override
  void initState() {
    super.initState();

    SavesController saves =
        Provider.of<SavesController>(context, listen: false);

    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
    saves.loadSavesMetadata(navigation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Center(
              child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 160.0),
            child: Text(
              'Loading',
              style: TextStyle(fontSize: getFontSize(34), color: Colors.white),
            ),
          )),
        ],
      ),
    );
  }
}
