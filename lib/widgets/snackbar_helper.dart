import 'package:flutter/material.dart';

class SnackBarHelper {
  static void show(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }
}
