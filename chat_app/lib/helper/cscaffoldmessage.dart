import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

void CustomScaffoldMessenger(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 2,
      showCloseIcon: true,
    ),
  );
}
