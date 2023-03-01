import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/widget/messages/message_tile.dart';
import 'package:forum/feature/groupchat/widgets/create_group_widget.dart';

import '../../../common/widget/text_field/search_textfiled.dart';

class ChannelWidget extends StatefulWidget {
  const ChannelWidget({super.key});

  @override
  State<ChannelWidget> createState() => _ChannelWidgetState();
}

class _ChannelWidgetState extends State<ChannelWidget> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchTextField(
            hintText: "Search",
            controller: _searchController,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomTheme.black,
        splashColor: CustomTheme.message,
        child: const Icon(Icons.group_add),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => new CreateGroup()));
        },
      ),
    );
  }
}
