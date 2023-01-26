import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:forum/feature/chat/widgets/chat_widget.dart';
import 'package:forum/feature/dashboard/widgets/channel_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatWidgets();
  }
}
