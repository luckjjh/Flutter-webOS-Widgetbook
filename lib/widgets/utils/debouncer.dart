import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  Debouncer({
    required this.delay,
  });
  final int delay;
  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(seconds: delay), action);
  }
}
