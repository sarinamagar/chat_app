import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/models/message_data.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({super.key, required this.messageData});
  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22),
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.amber,
      child: Row(
        children: const [
          CircleAvatar(
            radius: 22,
            backgroundColor: CustomTheme.black,
          ),
        ],
      ),
    );
  }
}
