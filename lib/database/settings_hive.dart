import 'package:flutter/material.dart';
import 'package:infitness/database/hive_utils.dart';

class SettingsHive {
  final _box = HiveUtils.boxSettings();

  ThemeMode getThemeMode() {
    return _box.get('theme-mode', defaultValue: ThemeMode.system);
  }

  setThemeMode(ThemeMode value) {
    _box.put('theme-mode', value);
  }
}
