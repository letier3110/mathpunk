import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/pawn/glow_effect.view.dart';
import 'package:mathpunk_cardgame/components/status_icon.dart';
import 'package:mathpunk_cardgame/classes/enemy/enemy.dart';
import 'package:mathpunk_cardgame/classes/intension.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/enums/intension_type.enum.dart';
import 'package:mathpunk_cardgame/utils/intension.util.dart';

import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;

Future<ui.Image> loadImage(String imagePath, int width, int height) async {
  ByteData bd = await rootBundle.load(imagePath);

  final Uint8List bytes = Uint8List.view(bd.buffer);

  final ui.Codec codec = await ui.instantiateImageCodec(bytes,
      targetHeight: height, targetWidth: width);

  final ui.Image image = (await codec.getNextFrame()).image;

  return image;
}

class EnemyPawnView extends ConsumerStatefulWidget {
  final double hpBarHeight = 20;
  final Enemy enemy;
  const EnemyPawnView({required this.enemy, Key? key}) : super(key: key);

  @override
  ConsumerState<EnemyPawnView> createState() => EnemyPawnViewView();
}

class EnemyPawnViewView extends ConsumerState<EnemyPawnView> {
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
    final gameState = ref.watch(gamestateProvider);

    var hp = widget.enemy.getHealth();
    var maxhp = widget.enemy.getMaxHealth();

    bool isPlayerAlive = gameState.playerCharacter!.health > 0;
    List<Status> statuses = widget.enemy.getStatuses();

    void onTapHandler() {
      ref.read(gamestateProvider.notifier).selectTarget(widget.enemy);
    }

    double width = MediaQuery.of(context).size.width;

    return Positioned(
      top: 60,
      right: width / 6,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          if (gameState.selectingTarget != null)
            FutureBuilder(
              future: loadImage('assets/goblin.png', width ~/ 3.9, width ~/ 5),
              builder: (BuildContext context, AsyncSnapshot<ui.Image> image) {
                if (image.hasData) {
                  return GlowEffectPawn(image: image.data!); // image is ready
                } else {
                  return Container(); // placeholder
                }
              },
            ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 72),
            height: width / 4,
            width: width / 4,
          ),
          Container(
            // padding: const EdgeInsets.all(8),
            height: width / 5,
            width: width / 4,
            child: Center(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Image.asset(
                  'assets/goblin.png',
                  height: width / 5,
                  width: width / 4,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            // child: Center(
            //   child: Text(
            //     widget.enemy.name,
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
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 50,
                  child: Center(
                    child: Text(
                      getIntensionType(widget.enemy.moveset.currentMove ??
                          Intension(intensionType: IntensionType.special)),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
          if (isPlayerAlive)
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: width / 4,
                  height: 64 + (width / 20),
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
              bottom: 120 + (width / 20),
              left: 0,
              right: 0,
              child: Container(
                width: width / 7,
                height: width / 7,
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
                bottom: 64 + (width / 20),
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
                              color: Colors.redAccent,
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
                ))
        ]),
      ),
    );
  }
}
