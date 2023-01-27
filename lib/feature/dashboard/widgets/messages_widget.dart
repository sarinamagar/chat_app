import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forum/common/widget/messages/message_tile.dart';
import 'package:forum/services/firebase_service.dart';

import '../../../common/widget/text_field/search_textfiled.dart';

class MessagesWidgets extends StatefulWidget {
  const MessagesWidgets({super.key});

  @override
  State<MessagesWidgets> createState() => _MessagesWidgetsState();
}

class _MessagesWidgetsState extends State<MessagesWidgets> {
  List<Map<String, dynamic>> users = [];
  final TextEditingController _searchController = TextEditingController();
  void onSearched() async {
    try {
      await FirebaseService.db
          .collection('users')
          .where("username", isEqualTo: _searchController.text)
          .get()
          .then((value) {
        setState(() {
          users = value.docs.map((doc) => doc.data()).toList();
          print(users.length);
          print(users);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchTextField(
            controller: _searchController,
            hintText: 'Search',
            onSearched: onSearched,
          ),
          users != null
              ? Expanded(
                  child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MessageTile(
                          username: users[index]['username'],
                        );
                      }),
                )
              : Container(),
          // users != null ? MessageTile() : Container(),
        ],
      ),
    );
  }
}
