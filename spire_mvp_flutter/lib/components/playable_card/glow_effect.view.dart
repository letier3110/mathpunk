import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';

class GlowEffect extends StatefulWidget {
  final Widget child;
  const GlowEffect({required this.child, Key? key}) : super(key: key);

  @override
  State<GlowEffect> createState() => GlowEffectView();
}

class GlowEffectView extends State<GlowEffect>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 2, end: 4).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.repeat(reverse: true);
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
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        // color: Colors.blueAccent,
        border: Border.all(color: Colors.white, width: animation.value),
        borderRadius: BorderRadius.circular(20),
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
