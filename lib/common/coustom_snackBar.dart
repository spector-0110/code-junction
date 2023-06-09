import 'package:flutter/material.dart';

void snackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String userNameFromEmail(String email) {
  return email.split('@')[0];
}
