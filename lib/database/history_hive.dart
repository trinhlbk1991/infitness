import 'package:infitness/database/hive_utils.dart';
import 'package:infitness/model/history.dart';

class HistoryHive {
  final _box = HiveUtils.boxHistory();

  List<History> getAll() {
    return _box.values.toList();
  }

  History? getById(int date) {
    final history = _box.get('$date');
    if (history == null) {
      return null;
    }
    return history;
  }

  save(History history) {
    _box.put('${history.date}', history);
  }

  delete(int date) {
    final workout = getById(date);
    if (workout != null) {
      _box.delete('$date');
    }
  }
}
