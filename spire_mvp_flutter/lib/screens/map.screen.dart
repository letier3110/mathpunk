import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/components/room_card.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Consumer<GamestateController>(
            builder: (gameStateContext, gameStateState, child) {
          return Container(
              color: Colors.redAccent,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemCount: gameStateState.gameMap.length,
                  itemBuilder: (BuildContext bc, int index) {
                    return _buildCarousel(
                        bc, index, gameStateState.gameMap[index]);
                  }));
          // child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: gameStateState.gameMap
          //         .map((e) => RoomCard(room: e))
          //         .toList()));
        })
      ]),
    );
  }

  Widget _buildCarousel(
      BuildContext context, int carouselIndex, List<Room> rooms) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: rooms
          .map((e) => SizedBox(
                // you may want to use an aspect ratio here for tablet support
                height: 200.0,
                width: 100,
                child: PageView.builder(
                  // store this controller in a State to save the carousel scroll position
                  controller: PageController(viewportFraction: 1),
                  itemBuilder: (BuildContext context, int itemIndex) {
                    return _buildCarouselItem(
                        context, carouselIndex, itemIndex, e);
                  },
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex, Room room) {
    return RoomCard(room: room);
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
