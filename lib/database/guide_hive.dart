// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:infitness/database/hive_utils.dart';

class GuideHive {
  final _box = HiveUtils.boxGuide();

  bool guideDeleteSet() {
    return _box.get('delete-set', defaultValue: true);
  }

  setGuideDeleteSet(bool value) {
    _box.put('delete-set', value);
  }
}
