import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';

import '../../../common/widget/messages/date_label.dart';

class ChatWidgets extends StatefulWidget {
  const ChatWidgets({super.key});

  @override
  State<ChatWidgets> createState() => _ChatWidgetsState();
}

class _ChatWidgetsState extends State<ChatWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "John Cena",
          style: CustomTextStyle.appText2,
        ),
        centerTitle: true,
        backgroundColor: CustomTheme.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: DateLabel(
        label: 'Yesterday',
      ),
    );
  }
}
