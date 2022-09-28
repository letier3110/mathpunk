import 'package:flutter/material.dart';

const wavecolor = Color.fromARGB(119, 52, 223, 46);

class GlowEffectCard extends StatefulWidget {
  final Widget child;
  final Color waveColor;
  const GlowEffectCard(
      {required this.child, this.waveColor = wavecolor, Key? key})
      : super(key: key);

  @override
  State<GlowEffectCard> createState() => GlowEffectCardView();
}

const double minAnimationValue = 1;
const double maxAnimationValue = 8;
const double divider = 1;

class GlowEffectCardView extends State<GlowEffectCard>
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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: widget.waveColor,
            blurRadius: 1,
            spreadRadius: values[0] / divider,
          ),
          BoxShadow(
            color: widget.waveColor,
            blurRadius: 1,
            spreadRadius: values[1] / divider,
          ),
          BoxShadow(
            color: widget.waveColor,
            blurRadius: 1,
            spreadRadius: values[2] / divider,
          ),
        ],
      ),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
