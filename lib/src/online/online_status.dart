import 'package:flutter/material.dart';

class OnlineStatus extends ChangeNotifier {
  static ValueNotifier<bool> online = ValueNotifier<bool>(false);
}
