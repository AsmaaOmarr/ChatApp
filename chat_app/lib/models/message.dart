// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/constants.dart';

class Message {
  final String message;
  final String id;
  Message({
    required this.message,
    required this.id,
  });

  factory Message.fromJson(JsonData) {
    return Message(message: JsonData['message'], id: JsonData['id']);
  }
}
