import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/enums/supported_locale.enum.dart';

const supportedLocales = [
  Locale('en', ''), // English, no country code
  Locale('pt', ''),
  Locale('uk', ''),
];

const supportedLocalesTexts = {
  SupportedLocale.en: 'enLocaleText',
  SupportedLocale.pt: 'ptLocaleText',
  SupportedLocale.uk: 'ukLocaleText',
};
