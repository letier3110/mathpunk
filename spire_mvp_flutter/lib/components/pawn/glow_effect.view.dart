import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class GlowEffectPawn extends StatefulWidget {
  final ui.Image image;
  const GlowEffectPawn({required this.image, Key? key}) : super(key: key);

  @override
  State<GlowEffectPawn> createState() => GlowEffectPawnView();
}

const double minAnimationValue = 1;
const double maxAnimationValue = 8;
const double divider = 1;

const wavecolor = Color.fromARGB(119, 52, 223, 46);

class GlowEffectPawnView extends State<GlowEffectPawn>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1600), vsync: this);
    animation = Tween<double>(begin: minAnimationValue, end: maxAnimationValue)
        .animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    var values = [
      animation.value,
      (((animation.value + 2.6) % maxAnimationValue) + minAnimationValue),
      (((animation.value + 5.3) % maxAnimationValue) + minAnimationValue),
    ];

    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, width / 160),
      child: Center(
        child: ShaderMask(
          blendMode: BlendMode.dstATop,
          shaderCallback: (Rect bounds) {
            return ui.ImageShader(
              widget.image,
              TileMode.mirror,
              TileMode.mirror,
              Matrix4.identity().storage,
            );
          },
          child: Container(
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(20),
            //   boxShadow: [
            //     BoxShadow(
            //       color: wavecolor,
            //       blurRadius: 1,
            //       spreadRadius: values[0] / divider,
            //     ),
            //     BoxShadow(
            //       color: wavecolor,
            //       blurRadius: 1,
            //       spreadRadius: values[1] / divider,
            //     ),
            //     BoxShadow(
            //       color: wavecolor,
            //       blurRadius: 1,
            //       spreadRadius: values[2] / divider,
            //     ),
            //   ],
            // ),
            color: wavecolor,
            height: (width * (values[0] / 8)) / 3.9 - 20,
            width: width / 3.9,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
