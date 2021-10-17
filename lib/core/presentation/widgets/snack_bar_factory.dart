import 'package:flutter/material.dart';

SnackBar buildSnackBarError(
    String msg, ScaffoldMessengerState scaffoldMessenger) {
  return SnackBar(
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.deepOrangeAccent,
    content: Text(
      msg,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        scaffoldMessenger.hideCurrentSnackBar();
      },
    ),
  );
}

SnackBar buildSnackBarInfo(
    String msg, ScaffoldMessengerState scaffoldMessenger) {
  return SnackBar(
    backgroundColor: Colors.blue[50],
    duration: const Duration(seconds: 3),
    content: Text(
      msg,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}
