import 'package:flutter/material.dart';

extension RouteSettingsExtensions on RouteSettings {
  String? getStringArg(String key) => (arguments as Map<String, dynamic>)[key];

  int? getIntArg(String key) => (arguments as Map<String, dynamic>)[key];

  bool? getBoolArg(String key) => (arguments as Map<String, dynamic>)[key];

  List<T>? getListArg<T>(String key) =>
      (arguments as Map<String, dynamic>)[key];

  T? getObjectArg<T>(String key) => (arguments as Map<String, dynamic>)[key];
}
