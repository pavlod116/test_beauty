import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showErrorFlushBarView(BuildContext context, String message) {


    Flushbar(
    message: message,
    icon: const Icon(
      Icons.error_outline,
      size: 28.0,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 5),
    leftBarIndicatorColor: Colors.red[300],
    backgroundColor: Colors.red.shade700,
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 5.0,
        offset: const Offset(0.0, 2.0),
      )
    ],
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}
