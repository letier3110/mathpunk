import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';

import 'package:spire_mvp_flutter/utils/font.util.dart';

class MindBloomView extends StatefulWidget {
  const MindBloomView({Key? key}) : super(key: key);

  @override
  State<MindBloomView> createState() => _MindBloomViewView();
}

class _MindBloomViewView extends State<MindBloomView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('mindBloom scene'));
  }
}
