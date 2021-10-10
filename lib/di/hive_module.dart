import 'package:infitness/database/settings_hive.dart';
import 'package:provider/provider.dart';

class HiveModule {
  HiveModule._();

  static final hives = [
    Provider<SettingsHive>(
      create: (context) => SettingsHive(),
    ),
  ];
}
