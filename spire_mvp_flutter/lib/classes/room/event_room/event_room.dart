import 'package:flutter/material.dart';

import '../room.dart';

class EventRoom extends Room {
  EventRoom({
    String roomId = '0',
  }) : super(roomEnemies: [], roomRewards: [], roomId: roomId);

  @override
  bool getCanLeaveRoom() {
    return true;
  }

  Widget getEventSceneComponent() {
    throw UnimplementedError();
  }
}
