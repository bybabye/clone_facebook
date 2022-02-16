import 'package:flutter/material.dart';

showSnackBar(String content, BuildContext context, bool check) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: check ? Colors.green : Colors.red,
      ),
    );
}
