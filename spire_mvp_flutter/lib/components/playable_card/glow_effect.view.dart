import 'package:flutter/material.dart';

class GlowEffect extends StatefulWidget {
  final Widget child;
  const GlowEffect({required this.child, Key? key}) : super(key: key);

  @override
  State<GlowEffect> createState() => GlowEffectView();
}

const double minAnimationValue = 1;
const double maxAnimationValue = 8;
const double divider = 1;

const wavecolor = Color.fromARGB(119, 13, 190, 235);

class GlowEffectView extends State<GlowEffect>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
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
    // return AnimatedContainer(
    //   padding: const EdgeInsets.all(8),
    //   margin: const EdgeInsets.all(4),
    //   duration: const Duration(seconds: 1),
    //   curve: Curves.easeIn,
    //   decoration: BoxDecoration(
    //     color: Colors.blueAccent,
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: widget.child,
    // );
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
            color: wavecolor,
            blurRadius: 1,
            spreadRadius: values[0] / divider,
          ),
          BoxShadow(
            color: wavecolor,
            blurRadius: 1,
            spreadRadius: values[1] / divider,
          ),
          BoxShadow(
            color: wavecolor,
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
