import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy.dart';
import 'package:spire_mvp_flutter/classes/intension.dart';
import 'package:spire_mvp_flutter/components/playable_card/glow_effect.view.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/enums/intension_type.enum.dart';
import 'package:spire_mvp_flutter/utils/intension.util.dart';

import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;

Future<ui.Image> loadImage(String imagePath, int width, int height) async {
  ByteData bd = await rootBundle.load(imagePath);

  final Uint8List bytes = Uint8List.view(bd.buffer);

  final ui.Codec codec = await ui.instantiateImageCodec(bytes,
      targetHeight: height, targetWidth: width);
  //  final codec = await ui.instantiateImageCodec(
  //   assetImageByteData.buffer.asUint8List(),
  //   targetHeight: height,
  //   targetWidth: width,
  // );

  final ui.Image image = (await codec.getNextFrame()).image;

  return image;
}

const double hpBarHeight = 20;

class EnemyPawnView extends StatefulWidget {
  final Enemy enemy;
  const EnemyPawnView({required this.enemy, Key? key}) : super(key: key);

  @override
  State<EnemyPawnView> createState() => EnemyPawnViewView();
}

class EnemyPawnViewView extends State<EnemyPawnView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var hp = widget.enemy.getHealth();
    var maxhp = widget.enemy.getMaxHealth();

    bool isPlayerAlive = gameState.playerCharacter!.health > 0;

    void onTapHandler() {
      gameState.selectTarget(widget.enemy);
    }

    double width = MediaQuery.of(context).size.width;

    return Positioned(
      top: 100,
      right: width / 6,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          if (gameState.selectingTarget != null)
            FutureBuilder(
              future:
                  loadImage('assets/goblin.png', width ~/ 3.9, width ~/ 3.9),
              builder: (BuildContext context, AsyncSnapshot<ui.Image> image) {
                if (image.hasData) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, width / 160),
                    child: Center(
                      child: ShaderMask(
                        blendMode: BlendMode.dstATop,
                        shaderCallback: (Rect bounds) {
                          return ui.ImageShader(
                            image.data!,
                            TileMode.mirror,
                            TileMode.mirror,
                            Matrix4.identity().storage,
                          );
                        },
                        child: Container(
                          color: const Color.fromARGB(119, 52, 223, 46),
                          height: width / 3.9,
                          width: width / 3.9,
                        ),
                      ),
                    ),
                  ); // image is ready
                } else {
                  return Container(); // placeholder
                }
              },
            ),
          Container(
            padding: const EdgeInsets.all(8),
            height: width / 4,
            width: width / 4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/goblin.png'), fit: BoxFit.cover),
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
                child: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(2),
                        height: hpBarHeight,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(hpBarHeight),
                          // border: Border.all(color: Colors.white, width: 2)
                        )),
                    Row(
                      children: [
                        Expanded(
                          flex: ((hp / maxhp) * 100).toInt(),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            height: hpBarHeight,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(hpBarHeight),
                              // border: Border.all(color: Colors.white, width: 2)
                            ),
                          ),
                        ),
                        Expanded(
                          flex: (((maxhp - hp) / maxhp) * 100).toInt(),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            height: hpBarHeight,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(hpBarHeight),
                              // border: Border.all(color: Colors.white, width: 2)
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      height: hpBarHeight,
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
