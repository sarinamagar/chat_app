import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forum/common/widget/messages/message_tile.dart';
import 'package:forum/feature/chat/widgets/chat_widget.dart';
import 'package:forum/services/firebase_service.dart';
import '../../../common/widget/text_field/search_textfiled.dart';

class MessagesWidgets extends StatefulWidget {
  const MessagesWidgets({super.key});

  @override
  State<MessagesWidgets> createState() => _MessagesWidgetsState();
}

class _MessagesWidgetsState extends State<MessagesWidgets> {
  static List<Map<String, dynamic>> users = [];
  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService firebaseService = FirebaseService();

  String userName = "";

  @override
  @override
  void initState() {
    super.initState();
    FirebaseService.db.collection('users').get().then((value) {
      setState(() {
        users = value.docs.map((doc) => doc.data()).toList();
      });
    });
  }

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
          print(_auth.currentUser);
          userName = _auth.currentUser!.email.toString();
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
                  child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data?.docs;
                      print("data ${data}");
                      return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MessageTile(
                              username: users[index]['username'],
                              onPressed: () {
                                String cId =
                                    chatRoomId(userName, users[index]['email']);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ChatWidgets(
                                          users: users,
                                          chatRoomId: cId,
                                          selectedUsername: users[index]
                                              ['username'],
                                        )));
                              },
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ))
              : Container(),
          // users != null ? MessageTile() : Container(),
        ],
      ),
    );
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
}
