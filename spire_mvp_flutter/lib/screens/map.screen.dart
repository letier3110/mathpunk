import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/components/room_card.dart';

class MapScreen extends StatefulWidget {
  final List<List<Room>> gameMap;

  const MapScreen({required this.gameMap, Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

const double rowHeight = 200;
const double columnWidth = 100;
const double topMargin = 20;

class RoomSlice {
  Room room;
  Offset offset;
  RoomSlice({required this.room, required this.offset});
}

class RoomTuple {
  Room room;
  Room targetRoom;
  Offset offset;
  RoomTuple(
      {required this.room, required this.targetRoom, required this.offset});
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    List<RoomSlice> roomsCoords = [];
    List<RoomTuple> roomsTuple = [];
    var i = 0;
    Map<String, RoomSlice> mapConnections = <String, RoomSlice>{};
    for (var roomSlice in widget.gameMap) {
      var j = 0;
      for (var room in roomSlice) {
        final slice = RoomSlice(
            room: room,
            offset: Offset(
                (j.toDouble() + 1 - roomSlice.length / 2) * columnWidth,
                (i.toDouble() + 0.5) * rowHeight));

        roomsCoords.add(slice);
        for (var nextRoom in room.nextRooms) {
          final tuple = RoomTuple(
              room: room,
              targetRoom: nextRoom,
              offset: Offset(
                  (j.toDouble() + 1 - roomSlice.length / 2) * columnWidth + 32,
                  (i.toDouble() + 0.5) * rowHeight + 32));
          roomsTuple.add(tuple);
        }
        j++;
        mapConnections[room.id] = slice;
      }
      i++;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/map_bg2.png',
              repeat: ImageRepeat.repeat,
            ),
          ),
          SizedBox(
            height: widget.gameMap.length * rowHeight + (topMargin * 2),
            width: width,
          ),
          ...roomsTuple
              .map((tuple) => MapConnection(
                  roomTuple: tuple, mapConnections: mapConnections))
              .toList(),
          ...roomsCoords
              .map((room) => MapCards(
                    roomSlice: room,
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class LinesPainter extends CustomPainter {
  final Offset? start, end;

  LinesPainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null) return;
    canvas.drawLine(
        start!,
        end!,
        Paint()
          ..strokeWidth = 4
          ..color = Colors.redAccent);
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end;
  }
}

class MapCards extends StatelessWidget {
  final RoomSlice roomSlice;

  const MapCards({Key? key, required this.roomSlice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double dxCenter = (width / 3);

    return Positioned(
        top: roomSlice.offset.dy,
        left: roomSlice.offset.dx + dxCenter,
        child: SizedBox(
            width: 64, height: 64, child: RoomCard(room: roomSlice.room)));
  }
}

class MapConnection extends StatelessWidget {
  final Map<String, RoomSlice> mapConnections;
  final RoomTuple roomTuple;

  const MapConnection(
      {Key? key, required this.roomTuple, required this.mapConnections})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    RoomSlice targetSlice =
        (mapConnections[roomTuple.targetRoom.id] as RoomSlice);

    double dxCenter = (width / 3);

    Offset targetOffset = Offset(
        (targetSlice.offset.dx + dxCenter) + 32, targetSlice.offset.dy + 32);

    Offset initialOffset =
        Offset(roomTuple.offset.dx + dxCenter, roomTuple.offset.dy);

    // double height = MediaQuery.of(context).size.height;

    return CustomPaint(
        size: Size(width, width),
        painter: LinesPainter(initialOffset, targetOffset));
  }
}
