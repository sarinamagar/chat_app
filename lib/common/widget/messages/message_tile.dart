import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';
import 'package:forum/feature/chat/screens/chat_screen.dart';
import 'package:forum/models/message_data.dart';

class MessageTile extends StatelessWidget {
  MessageTile({
    super.key,
    required this.username,
    required this.onPressed,
    required this.imageUrl,
  });
  final String username;
  final String imageUrl;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: CustomTheme.divider))),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: CustomTheme.black,
              backgroundImage: NetworkImage(imageUrl),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
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
            const Text(
              "12 Jan, 23",
              style: CustomTextStyle.date,
            )
          ],
        ),
      ),
    );
  }
}
