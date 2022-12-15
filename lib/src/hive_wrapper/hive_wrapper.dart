import 'package:hive/hive.dart';

class HiveWrapper {
  static Box getUserBox() {
    return Hive.box('user');
  }

  static String? getDisplayName() {
    final box = getUserBox();
    return box.get('name');
  }

  static Future<void> setDisplayName(String name) async {
    final box = getUserBox();
    await box.put('name', name);
  }
}
