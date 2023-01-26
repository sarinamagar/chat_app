import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';
import 'package:forum/feature/chat/screens/chat_screen.dart';
import 'package:forum/models/message_data.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new ChatScreen()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: CustomTheme.divider))),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: CustomTheme.black,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sarina",
                      style: CustomTextStyle.username,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "john says hi",
                      style: CustomTextStyle.message,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "12 Jan, 23",
              style: CustomTextStyle.date,
            )
          ],
        ),
      ),
    );
  }
}
