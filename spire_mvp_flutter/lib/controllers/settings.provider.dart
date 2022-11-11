import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/enums/supported_locale.enum.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsNotifierInterface>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<SettingsNotifierInterface> {
  SettingsNotifier() : super(SettingsNotifierInterface());

  void changeAudioVolume(double volume) {
    state = SettingsNotifierInterface(
        audioAmbientVolume: volume, selectedLocale: state.selectedLocale);
  }

  void changeSelectedLocale(SupportedLocale locale) {
    state = SettingsNotifierInterface(
        audioAmbientVolume: state.audioAmbientVolume, selectedLocale: locale);
  }

  SettingsNotifierInterface fromJson(SettingsNotifierInterface savedInfo) {
    state = savedInfo;
    return state;
  }

  Map toJson() {
    return SettingsNotifierInterface(
            audioAmbientVolume: state.audioAmbientVolume,
            selectedLocale: state.selectedLocale)
        .toJson();
  }
}

class SettingsNotifierInterface {
  SettingsNotifierInterface({
    this.audioAmbientVolume = 1,
    this.selectedLocale = SupportedLocale.en,
  });

  double audioAmbientVolume = 1;
  SupportedLocale selectedLocale = SupportedLocale.en;

  factory SettingsNotifierInterface.fromJson(dynamic json) {
    double jsonAudioAmbientVolume = double.parse(json['audioAmbientVolume']);

    SupportedLocale jsonSelectedLocale =
        decodeSupportedLocaleFromJson(json['selectedLocale']);

    SettingsNotifierInterface result = SettingsNotifierInterface(
        audioAmbientVolume: jsonAudioAmbientVolume,
        selectedLocale: jsonSelectedLocale);

    return result;
  }

  Map toJson() => {
        'audioAmbientVolume': audioAmbientVolume.toString(),
        'selectedLocale': selectedLocale.toString(),
      };
}
