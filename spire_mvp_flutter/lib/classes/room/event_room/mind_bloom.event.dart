import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/room/event_room/event_room.dart';
import 'package:spire_mvp_flutter/components/event_room/mind_bloom.view.dart';

class MindBloomEventRoom extends EventRoom {
  bool canLeaveRoom = false;

  MindBloomEventRoom({String roomId = '0'}) : super(roomId: roomId);

  @override
  bool getCanLeaveRoom() {
    return canLeaveRoom;
  }

  void setCanLeaveRoom(bool canLeaveRoom) {
    this.canLeaveRoom = canLeaveRoom;
  }

  @override
  Widget getEventSceneComponent() {
    return MindBloomView(room: this);
  }
}
