import 'package:flutter/material.dart';

/// extension for simply property of context aplication
extension ContextExt on BuildContext {
  /// get theme
  ThemeData get theme {
    return Theme.of(this);
  }

  /// get text theme
  TextTheme get textTheme {
    return theme.textTheme;
  }

  /// get media query
  MediaQueryData get mediaQuery {
    return MediaQuery.of(this);
  }

  /// get width of device
  double get widthSize {
    return mediaQuery.size.width;
  }

  /// get height of device
  double get heightSize {
    return mediaQuery.size.height;
  }

  // --- Navigator ---

  /// for push
  Future<void> push({required Widget page}) {
    return Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  Future<void> pushReplacement({required Widget page}) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
