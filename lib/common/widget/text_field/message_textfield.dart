import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';

class MessageTextField extends StatelessWidget {
  MessageTextField(
      {super.key,
      required this.sendMessage,
      required this.controller,
      this.sendImage});
  final void Function() sendMessage;
  final void Function()? sendImage;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: sendImage,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: CustomTheme.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: CustomTheme.divider,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Center(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: "Enter message...",
                            hintStyle: CustomTextStyle.messageHint,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: FloatingActionButton(
                        backgroundColor: CustomTheme.black,
                        elevation: 0,
                        onPressed: sendMessage,
                        child: Icon(
                          Icons.send,
                          color: CustomTheme.divider,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
