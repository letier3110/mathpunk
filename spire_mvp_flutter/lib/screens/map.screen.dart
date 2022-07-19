import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/components/room_card.dart';

class MapScreen extends StatefulWidget {
  final List<List<Room>> gameMap;

  const MapScreen({required this.gameMap, Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<List<GlobalKey<RoomCardView>>> keys = [];
  @override
  void initState() {
    super.initState();
    keys = widget.gameMap
        .map((x) =>
            x.map((y) => GlobalKey<RoomCardView>(debugLabel: y.id)).toList())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var gameMap = widget.gameMap;

    return Scaffold(
      body: Stack(children: [
        Container(
            color: Colors.black54,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                itemCount: gameMap.length,
                itemBuilder: (BuildContext bc, int index) {
                  return _buildCarousel(bc, index, gameMap[index], keys[index]);
                })),
        Lines(roomKeys: keys)
      ]),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex,
      List<Room> rooms, List<GlobalKey<RoomCardView>> keys) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: rooms
          .asMap()
          .entries
          .map((entry) => Container(
                // you may want to use an aspect ratio here for tablet support
                height: 64,
                width: 64,
                margin: const EdgeInsets.all(18),
                child: PageView.builder(
                  // store this controller in a State to save the carousel scroll position
                  controller: PageController(viewportFraction: 1),
                  itemBuilder: (BuildContext context, int itemIndex) {
                    return _buildCarouselItem(
                        context,
                        carouselIndex,
                        itemIndex,
                        entry.value,
                        keys.length <= entry.key ? null : keys[entry.key]);
                  },
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCarouselItem(BuildContext context, int carouselIndex,
      int itemIndex, Room room, GlobalKey<RoomCardView>? key) {
    return RoomCard(key: key, room: room);
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 4.0),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: Colors.grey,
    //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
    //     ),
    //   ),
    // );
  }
}

class Lines extends StatefulWidget {
  final List<List<GlobalKey<RoomCardView>>> roomKeys;

  const Lines({required this.roomKeys, Key? key}) : super(key: key);

  @override
  createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  Offset? start;
  Offset? end;

  @override
  build(_) {
    return Stack(
      children: widget.roomKeys
          .map((roomSlice) => Stack(
                // children: [Text('a')],
                children: roomSlice
                    .map((roomKey) => Stack(
                          children: roomKey.currentState == null
                              ? []
                              : roomKey.currentState!.widget.room.nextRooms
                                  .map((room) => CustomPaint(
                                        size: Size.infinite,
                                        painter: LinesPainter(
                                            (roomKey.currentContext!
                                                        .findRenderObject()
                                                    as RenderBox)
                                                .localToGlobal(Offset.zero),
                                            (findRoomInstanceFromArriveOfLists(
                                                            room,
                                                            widget.roomKeys)
                                                        .currentContext!
                                                        .findRenderObject()
                                                    as RenderBox)
                                                .localToGlobal(Offset.zero)),
                                      ))
                                  .toList(),
                        ))
                    .toList(),
              ))
          .toList(),
    );
  }
}

GlobalKey<RoomCardView> findRoomInstanceFromArriveOfLists(
    Room startRoom, List<List<GlobalKey<RoomCardView>>> initialArray) {
  for (var i = 0; i < initialArray.length; i++) {
    for (var j = 0; j < initialArray[i].length; j++) {
      if (Room.isEqual(
          initialArray[i][j].currentState!.widget.room, startRoom)) {
        return initialArray[i][j];
      }
    }
  }
  return initialArray[0][0];
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
