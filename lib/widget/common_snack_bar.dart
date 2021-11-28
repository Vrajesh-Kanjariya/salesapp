import 'package:flutter/material.dart';

displayMessage(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
