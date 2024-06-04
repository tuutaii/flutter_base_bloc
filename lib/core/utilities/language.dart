import 'package:flutter/material.dart';

class AppLanguage {
  AppLanguage._();

//Custom your language
  static Locale defaultLanguage = const Locale('en');

  static final supportLanguage = [
    const Locale('en', 'EN'),
    const Locale('th', 'TH'),
  ];
}
