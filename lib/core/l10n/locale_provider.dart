import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  throw UnimplementedError(); // It's overridden in main.dart
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(Locale initialLocale) : super(initialLocale);

  static Future<LocaleNotifier> initializeLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('selectedLocale') ?? 'en';
    final countryCode = languageCode == 'en' ? 'US' : 'MX';
    return LocaleNotifier(Locale(languageCode, countryCode));
  }

  Future<void> changeLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    final countryCode = languageCode == 'en' ? 'US' : 'MX';
    state = Locale(languageCode, countryCode);
    await prefs.setString('selectedLocale', languageCode);
  }
}
