import 'package:flutter/material.dart';

@immutable
class MessageData {
  final String senderName;
  final String Message;
  final DateTime MessageDate;
  final String dateMessage;
  final String profilePicture;

  MessageData({
    required this.senderName,
    required this.Message,
    required this.MessageDate,
    required this.dateMessage,
    required this.profilePicture,
  });
}
