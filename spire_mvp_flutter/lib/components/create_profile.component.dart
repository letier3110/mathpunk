import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/controllers/saves.controller.dart';

class CreateProfileComponent extends StatefulWidget {
  const CreateProfileComponent({Key? key}) : super(key: key);

  @override
  State<CreateProfileComponent> createState() => CreateProfileComponentView();
}

class CreateProfileComponentView extends State<CreateProfileComponent> {
  String profileName = '';

  @override
  Widget build(BuildContext context) {
    SavesController saves =
        Provider.of<SavesController>(context, listen: false);

    void onTapHandler() {
      saves.createNewSlot(profileName);
    }

    return Center(
        child: Container(
            height: 220,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(4.0)),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Write your name',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                // Container(
                // margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                // child:
                TextField(
                  onChanged: (text) {
                    profileName = text;
                  },
                  // maxLength: 10,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
                // ),
                // Container(
                // margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                // child:
                ElevatedButton(
                  onPressed: onTapHandler,
                  // style: ElevatedButton.styleFrom(
                  //     surfaceTintColor: Colors.greenAccent),
                  child: const Text("Create"),
                ),
                // )
              ],
            )));
  }
}
