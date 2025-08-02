import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SnackBarType { success, error, info, warning }

class CustomSnackBar {
  static const Color _successColor = Color.fromARGB(255, 74, 183, 85);
  static const Color _errorColor = Color.fromARGB(255, 194, 81, 81);
  static const Color _infoColor = Color.fromRGBO(111, 86, 221, 1);
  static const Color _warningColor = Color.fromARGB(255, 255, 193, 7);

  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      duration: duration,
      backgroundColor: _getBackgroundColor(type),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.info,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
    );
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _successColor;
      case SnackBarType.error:
        return _errorColor;
      case SnackBarType.info:
        return _infoColor;
      case SnackBarType.warning:
        return _warningColor;
    }
  }
}
