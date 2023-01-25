import 'package:flutter/material.dart';

class MessagesWidgets extends StatefulWidget {
  const MessagesWidgets({super.key});

  @override
  State<MessagesWidgets> createState() => _MessagesWidgetsState();
}

class _MessagesWidgetsState extends State<MessagesWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Messages"),
      ),
    );
  }
}
