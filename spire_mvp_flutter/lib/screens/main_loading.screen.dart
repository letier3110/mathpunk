import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/controllers/saves.provider.dart';

class MainLoadingScreen extends ConsumerStatefulWidget {
  const MainLoadingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainLoadingScreen> createState() => _MainLoadingScreenState();
}

class _MainLoadingScreenState extends ConsumerState<MainLoadingScreen> {
  @override
  void initState() {
    super.initState();

    final saves = ref.read(savesProvider.notifier);
    final navigation = ref.read(navigationProvider.notifier);

    saves.loadSavesMetadata(navigation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Center(
              child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 160.0),
            child: Text(
              AppLocalizations.of(context)!.loading,
              style: const TextStyle(fontSize: 34, color: Colors.white),
            ),
          )),
        ],
      ),
    );
  }
}
