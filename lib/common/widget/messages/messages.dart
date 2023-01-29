import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final Timestamp time;
  final String message;
  ChatMessage({
    required this.time,
    required this.message,
  });
}
