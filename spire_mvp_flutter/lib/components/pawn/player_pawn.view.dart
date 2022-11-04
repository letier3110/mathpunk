import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/status_icon.dart';
import 'package:provider/provider.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';

class PlayerPawnView extends StatefulWidget {
  final double hpBarHeight = 20;
  const PlayerPawnView({Key? key}) : super(key: key);

  @override
  State<PlayerPawnView> createState() => PlayerPawnViewView();
}

class PlayerPawnViewView extends State<PlayerPawnView> {
  bool _isShowTooltip = false;
  Status? selectedStatus;

  void _showTooltip(Status status) {
    setState(() {
      _isShowTooltip = true;
      selectedStatus = status;
    });
  }

  void _hideTooltip() {
    setState(() {
      _isShowTooltip = false;
      selectedStatus = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    List<Status> statuses = gameState.playerCharacter?.getStatuses() ?? [];
    int block = castStatusToInt(statuses, BlockStatus);

    var hp = gameState.playerCharacter?.health ?? 0;
    var maxhp = gameState.playerCharacter?.maxHealth ?? 0;
    bool isPlayerAlive = gameState.playerCharacter!.health > 0;

    double width = MediaQuery.of(context).size.width;

    void onTapHandler() {
      // TODO: implement drawpile tap handler
    }

    return Positioned(
      top: 60,
      left: width / 6,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            // padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 72),
            height: width / 4,
            width: width / 4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/hero.png'), fit: BoxFit.cover),
            ),
            // child: Center(
            //   child: Text(
            //     'Player',
            //     textAlign: TextAlign.left,
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 22,
            //         fontWeight: FontWeight.w600),
            //   ),
            // ),
          ),
          if (isPlayerAlive)
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: width / 4,
                  height: 64,
                  child: Center(
                    child: GridView.count(
                      crossAxisCount: 8,
                      children: statuses
                          .where((element) => element.isShowStatus())
                          .map((e) => StatusIcon(
                                status: e,
                                onEnter: (event) => _showTooltip(e),
                                onExit: (event) => _hideTooltip(),
                              ))
                          .toList(),
                    ),
                  ),
                )),
          if (isPlayerAlive && _isShowTooltip && selectedStatus != null)
            Positioned(
              bottom: 72,
              left: 0,
              right: 0,
              child: Container(
                width: width / 6,
                height: width / 6,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/menu_bg_2.png'),
                      fit: BoxFit.fill),
                ),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(children: [
                    const Spacer(),
                    selectedStatus!.getStatusName(context),
                    selectedStatus!.getStatusDescription(context),
                    const Spacer(),
                  ]),
                ),
              ),
            ),
          if (isPlayerAlive)
            Positioned(
                bottom: 64,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(2),
                        height: widget.hpBarHeight,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.circular(widget.hpBarHeight),
                          // border: Border.all(color: Colors.white, width: 2)
                        )),
                    Row(
                      children: [
                        Expanded(
                          flex: ((hp / maxhp) * 100).toInt(),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            height: widget.hpBarHeight,
                            decoration: BoxDecoration(
                              color:
                                  block > 0 ? Colors.purple : Colors.redAccent,
                              borderRadius:
                                  BorderRadius.circular(widget.hpBarHeight),
                              // border: Border.all(color: Colors.white, width: 2)
                            ),
                          ),
                        ),
                        if (hp != maxhp)
                          Expanded(
                            flex: (((maxhp - hp) / maxhp) * 100).toInt(),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              height: widget.hpBarHeight,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.circular(widget.hpBarHeight),
                                // border: Border.all(color: Colors.white, width: 2)
                              ),
                            ),
                          )
                      ],
                    ),
                    if (block > 0)
                      Positioned(
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          height: widget.hpBarHeight,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius:
                                BorderRadius.circular(widget.hpBarHeight),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(
                                    Icons.shield,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                                Text(
                                  '$block',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      height: widget.hpBarHeight,
                      child: Center(
                        child: Text(
                          '$hp / $maxhp',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                )),
        ]),
      ),
    );
  }
}
