import 'package:flutter/material.dart';

import '../room.dart';

class EventRoom extends Room {
  EventRoom({
    String roomId = '0',
  }) : super(roomEnemies: [], roomRewards: [], roomId: roomId);

  void setId(String id) {
    this.id = id;
  }

  @override
  bool getCanLeaveRoom() {
    return true;
  }

  Widget getEventSceneComponent() {
    throw UnimplementedError();
  }
}
