import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String messageContent;
  final Timestamp time;
  ChatMessage({required this.time, required this.messageContent});
}
