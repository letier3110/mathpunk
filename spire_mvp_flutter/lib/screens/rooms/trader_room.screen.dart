import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/classes/room/trade_room.dart';
import 'package:spire_mvp_flutter/components/game_forward_button.dart';
import 'package:spire_mvp_flutter/components/room/trader.view.dart';
import 'package:spire_mvp_flutter/components/room/trader_pawn.view.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class TraderRoomScreen extends StatefulWidget {
  final TradeRoom room;

  const TraderRoomScreen({required this.room, Key? key}) : super(key: key);

  @override
  State<TraderRoomScreen> createState() => _TraderRoomScreenState();
}

class _TraderRoomScreenState extends State<TraderRoomScreen> {
  bool inTradeMenu = false;

  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    void traderPawnPress() {
      setState(() {
        inTradeMenu = true;
      });
    }

    void proceedHandler() {
      gameState.enterMap();
    }

    return Container(
        color: const Color(0xFF222222),
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          if (!inTradeMenu)
            TraderPawnView(
              callback: traderPawnPress,
            ),
          if (inTradeMenu) TraderView(rewards: widget.room.rewards),
          if (!inTradeMenu && widget.room.visitedTrader)
            GameForwardButton(
              goForward: proceedHandler,
            ),
        ]));
  }
}
