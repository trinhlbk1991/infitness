import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsHive {
  final box = Hive.box('settings');

  ThemeMode getThemeMode() {
    return box.get('theme-mode', defaultValue: ThemeMode.system);
  }

  setThemeMode(ThemeMode value) {
    box.put('theme-mode', value);
  }
}
