import 'package:flutter/material.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';

class AdsPreference {
  final int value;
  const AdsPreference(this.value);

  static const none = AdsPreference(0);
  static const minimal = AdsPreference(1);
  static const int maxValue = 1;

  static ValueNotifier<AdsPreference> current = ValueNotifier<AdsPreference>(
    HiveWrapper.getAdsPreference(),
  );

  @override
  String toString() {
    switch (value) {
      case 1:
        return 'minimal';
      default:
        return 'none';
    }
  }

  @override
  bool operator ==(other) {
    if (other is! AdsPreference) return false;
    return other.value == value;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
