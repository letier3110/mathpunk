import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/controllers/saves.provider.dart';

class CreateProfileComponent extends ConsumerStatefulWidget {
  const CreateProfileComponent({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateProfileComponent> createState() =>
      CreateProfileComponentView();
}

class CreateProfileComponentView extends ConsumerState<CreateProfileComponent> {
  String profileName = '';

  @override
  Widget build(BuildContext context) {
    final saves = ref.read(savesProvider.notifier);

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
                Text(
                  AppLocalizations.of(context)!.introWriteYourNameText,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.enterNameText,
                    hintText: AppLocalizations.of(context)!.enterNameHint,
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
                  child:
                      Text(AppLocalizations.of(context)!.createNameButtonText),
                ),
                // )
              ],
            )));
  }
}
