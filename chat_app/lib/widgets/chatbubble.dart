// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/constants.dart';

class ChatBubble extends StatelessWidget {
  Message message;
  ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
        margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
          color: kPrimaryColor,
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  Message message;
  ChatBubbleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
        margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
            bottomLeft: Radius.circular(28),
          ),
          color: const Color.fromARGB(255, 80, 127, 150),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
