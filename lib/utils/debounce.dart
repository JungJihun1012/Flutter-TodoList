import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int millisecounds;
  Debounce({
    this.millisecounds = 500,
  });

  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: millisecounds), action);
  }
}