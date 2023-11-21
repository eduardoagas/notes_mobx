import 'package:flutter/material.dart';

class GetScreenSize {
  Size getScreenSize() {
    return MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.first)
        .size;
  }
}
