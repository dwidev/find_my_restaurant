import 'package:find_my_restaurant/core/core.dart';
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

  /// for pop
  void pop() => Navigator.pop(this);

  // ---- shackbar ----
  Future<void> showSnackbar(String message) async {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: textTheme.bodyText1?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: secondaryColor,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
