

import 'package:flutter/material.dart';

void showScaffold(
  BuildContext context,
  String message
) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}