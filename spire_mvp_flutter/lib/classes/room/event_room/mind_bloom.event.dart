import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/room/event_room/event_room.dart';
import 'package:spire_mvp_flutter/components/event_room/mind_bloom.view.dart';

class MindBloomEventRoom extends EventRoom {
  MindBloomEventRoom() : super();

  @override
  bool getCanLeaveRoom() {
    return true;
  }

  @override
  Widget getEventSceneComponent() {
    return const MindBloomView();
  }
}
