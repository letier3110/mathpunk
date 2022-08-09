import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';

import 'package:spire_mvp_flutter/utils/font.util.dart';

class ConsumableView extends StatefulWidget {
  final ConsumableItem item;
  const ConsumableView({required this.item, Key? key}) : super(key: key);

  @override
  State<ConsumableView> createState() => ConsumableViewView();
}

class ConsumableViewView extends State<ConsumableView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: const Icon(
              Icons.local_bar,
              color: Colors.pinkAccent,
            ),
          ),
          Text(
            widget.item.name,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: getFontSize(12),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
