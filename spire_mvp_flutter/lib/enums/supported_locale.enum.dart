import 'package:flutter/material.dart';

enum SupportedLocale { en, pt, uk }

SupportedLocale decodeSupportedLocaleFromJson(dynamic json) {
  switch (json) {
    case 'SupportedLocale.en':
      return SupportedLocale.en;
    case 'SupportedLocale.pt':
      return SupportedLocale.pt;
    case 'SupportedLocale.uk':
    default:
      return SupportedLocale.uk;
  }
}

Locale getLocaleFromSupportedLocaleEnum(SupportedLocale supportedLocale) {
  switch (supportedLocale) {
    case SupportedLocale.en:
      return const Locale('en', '');
    case SupportedLocale.pt:
      return const Locale('pt', '');
    case SupportedLocale.uk:
    default:
      return const Locale('uk', '');
  }
}
