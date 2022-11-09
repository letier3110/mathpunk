import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/room/trade_room.dart';
import 'package:mathpunk_cardgame/components/game_back_button.dart';
import 'package:mathpunk_cardgame/components/game_forward_button.dart';
import 'package:mathpunk_cardgame/components/room/trader.view.dart';
import 'package:mathpunk_cardgame/components/room/trader_pawn.view.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class TraderRoomScreen extends ConsumerStatefulWidget {
  final TradeRoom room;

  const TraderRoomScreen({required this.room, Key? key}) : super(key: key);

  @override
  ConsumerState<TraderRoomScreen> createState() => _TraderRoomScreenState();
}

class _TraderRoomScreenState extends ConsumerState<TraderRoomScreen> {
  bool inTradeMenu = false;
  final player = AudioPlayer();

  void playMapTheme() async {
    await player.setSource(AssetSource('ambient/trade.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
    await player.resume();
  }

  void stopTheme() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
  }

  @override
  void initState() {
    super.initState();
    playMapTheme();
  }

  @override
  void dispose() {
    stopTheme();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.read(gamestateProvider.notifier);

    void traderPawnPress() {
      setState(() {
        inTradeMenu = true;
      });
      gameState.visitTrader();
    }

    void back() {
      setState(() {
        inTradeMenu = false;
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
          if (inTradeMenu) TraderView(room: widget.room),
          if (inTradeMenu)
            GameBackButton(
              goBack: back,
            ),
          if (!inTradeMenu && widget.room.visitedTrader)
            GameForwardButton(
              goForward: proceedHandler,
            ),
        ]));
  }
}
