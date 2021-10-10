import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsHive {
  final _box = Hive.openBox('settings');

  Future<ThemeMode> getThemeMode() async {
    return await _box
        .then((box) => box.get('theme-mode', defaultValue: ThemeMode.system));
  }

  setThemeMode(ThemeMode value) async {
    await _box.then((box) => box.put('theme-mode', value));
  }
}
