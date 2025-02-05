import 'package:flutter/material.dart';

extension LocaleExtensions on Locale {
  String toLanguageTag() {
    return '$languageCode${countryCode != null ? '-$countryCode' : ''}';
  }
}
