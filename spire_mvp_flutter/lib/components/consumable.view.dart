import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';

class ConsumableView extends StatefulWidget {
  final ConsumableItem item;
  final Function? onTap;
  final bool disabled;
  const ConsumableView(
      {required this.item, this.onTap, this.disabled = false, Key? key})
      : super(key: key);

  @override
  State<ConsumableView> createState() => ConsumableViewView();
}

class ConsumableViewView extends State<ConsumableView> {
  @override
  Widget build(BuildContext context) {
    void onTapHandler() {
      if (widget.disabled) {
        return;
      }
      if (widget.onTap != null) {
        widget.onTap!();
        return;
      }
    }

    return SizedBox(
      width: 120,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.item.getAssetImage()),
                    fit: BoxFit.fill),
              ),
            ),
            Text(
              widget.item.getItemName(context),
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
