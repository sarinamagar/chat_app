import 'package:flutter/material.dart';
import 'package:forum/common/widget/messages/message_tile.dart';

import '../../../common/widget/text_field/search_textfiled.dart';

class MessagesWidgets extends StatefulWidget {
  const MessagesWidgets({super.key});

  @override
  State<MessagesWidgets> createState() => _MessagesWidgetsState();
}

class _MessagesWidgetsState extends State<MessagesWidgets> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchTextField(
            controller: _searchController,
            hintText: 'Search',
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return MessageTile();
                }),
          )
        ],
      ),
    );
  }
}
