import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';
import 'package:forum/common/widget/messages/received_message.dart';
import 'package:forum/common/widget/messages/sent_message.dart';

import '../../../common/widget/messages/date_label.dart';
import '../../../common/widget/text_field/message_textfield.dart';
import '../../../model/messages.dart';

class ChatWidgets extends StatefulWidget {
  const ChatWidgets({super.key});

  @override
  State<ChatWidgets> createState() => _ChatWidgetsState();
}

class _ChatWidgetsState extends State<ChatWidgets> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomTheme.black,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: CustomTheme.divider,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomTheme.primaryColor,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "John Cena",
                          style: CustomTextStyle.appText2,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Online",
                          style: CustomTextStyle.date,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.settings,
                    color: CustomTheme.divider,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            DateLabel(
              label: 'Yesterday',
            ),
            ReceivedMessage(message: "Hello"),
            SentMessage(message: "Hello"),
            SizedBox(height: 490, child: MessageTextField()),
          ],
        ),
      ),
    );
  }
}
