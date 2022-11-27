import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/components/menu_back_button.dart';
import 'package:mathpunk_cardgame/controllers/settings.provider.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';
import 'package:mathpunk_cardgame/enums/supported_locale.enum.dart';
import 'package:mathpunk_cardgame/storage/settings.storage.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  SettingsStorage settingsStorage = SettingsStorage();

  void changeSliderValue(double value) {
    ref.read(settingsProvider.notifier).changeAudioVolume(value / 100);

    settingsStorage.writeState(ref.read(settingsProvider.notifier));
  }

  void changeDropdownValue(String? value) {
    SupportedLocale locale = decodeSupportedLocaleFromJson(value.toString());
    ref.read(settingsProvider.notifier).changeSelectedLocale(locale);
    // double audioVolume = ref.read(audioVolumeProvider);
    // ref.read(selectedLocaleProvider.notifier).state = locale;

    settingsStorage.writeState(ref.read(settingsProvider.notifier));
  }

  @override
  Widget build(BuildContext context) {
    // final audioAmbientVolume = ref.watch(audioVolumeProvider);
    // final selectedLocale = ref.watch(selectedLocaleProvider);
    final selectedLocale =
        ref.watch(settingsProvider.select((value) => value.selectedLocale));
    final audioAmbientVolume =
        ref.watch(settingsProvider.select((value) => value.audioAmbientVolume));

    // final settingsNotifier = ref.read(settingsProvider.notifier);

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
            ),
          ),
          Center(
            child: SizedBox(
              width: width / 2,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Language:'),
                        DropdownButton<String>(
                            value: selectedLocale.toString(),
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.blueAccent),
                            underline: Container(
                              height: 2,
                              color: Colors.blueAccent,
                            ),
                            onChanged: changeDropdownValue,
                            // onChanged: ((value) {
                            //   settingsNotifier.changeSelectedLocale(
                            //       value as SupportedLocale);
                            // }),
                            items: [
                              DropdownMenuItem<String>(
                                value: SupportedLocale.en.toString(),
                                child: Text(
                                    AppLocalizations.of(context)!.enLocaleText),
                              ),
                              DropdownMenuItem<String>(
                                value: SupportedLocale.pt.toString(),
                                child: Text(
                                    AppLocalizations.of(context)!.ptLocaleText),
                              ),
                              DropdownMenuItem<String>(
                                value: SupportedLocale.uk.toString(),
                                child: Text(
                                    AppLocalizations.of(context)!.ukLocaleText),
                              )
                            ]),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Audio Volume:'),
                        Expanded(
                            child: Slider(
                          value: audioAmbientVolume * 100,
                          max: 100,
                          divisions: 10,
                          label: (audioAmbientVolume * 100).round().toString(),
                          onChanged: changeSliderValue,
                          // onChanged: ((value) => settingsNotifier
                          //     .changeAudioVolume(value / 100)),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const MenuBackButton(
            backScreen: ScreenEnum.mainMenu,
          ),
        ],
      ),
    );
  }
}
