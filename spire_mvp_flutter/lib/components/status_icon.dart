import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/utils/status.util.dart';

void onEnter() {
  //
}

class StatusIcon extends StatefulWidget {
  final Status status;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final Function(PointerHoverEvent)? onHover;

  const StatusIcon(
      {required this.status, this.onEnter, this.onExit, this.onHover, Key? key})
      : super(key: key);

  @override
  State<StatusIcon> createState() => StatusIconView();
}

class StatusIconView extends State<StatusIcon> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        // onTap: onTapHandler,
        onEnter: (event) => {
              if (widget.onEnter != null) {widget.onEnter!(event)}
            },
        onExit: (event) => {
              if (widget.onExit != null) {widget.onExit!(event)}
            },
        onHover: (event) => {
              if (widget.onHover != null) {widget.onHover!(event)}
            },
        child: Container(
          margin: const EdgeInsets.all(4),
          color: widget.status.isStatusPositive() ? Colors.green : Colors.red,
          child: Center(
              child: Row(
            children: [
              Text(widget.status.stack.toInt().toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              getStatusIcon(widget.status)
            ],
          )),
        ));
  }
}
