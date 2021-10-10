import 'package:infitness/database/settings_hive.dart';
import 'package:provider/provider.dart';

class UseCaseModule {
  UseCaseModule._();

  static final hives = [
    Provider<SettingsHive>(
      create: (context) => SettingsHive(),
    ),
  ];
}
