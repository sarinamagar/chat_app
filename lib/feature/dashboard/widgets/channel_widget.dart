import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/widget/messages/message_tile.dart';
import 'package:forum/feature/chat/widgets/group_chat_widget.dart';
import 'package:forum/feature/groupchat/widgets/create_group_widget.dart';

import '../../../common/widget/text_field/search_textfiled.dart';

class ChannelWidget extends StatefulWidget {
  const ChannelWidget({super.key});

  @override
  State<ChannelWidget> createState() => _ChannelWidgetState();
}

class _ChannelWidgetState extends State<ChannelWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  List groupList = [];

  @override
  void initState() {
    super.initState();
    getGroups();
  }

  // void getGroups() async {
  //   String? uid = _auth.currentUser!.email;
  //   print("${uid}uidddddd");
  //   await _firestore
  //       // .collection('users')
  //       // .doc(uid)
  //       .collection('group')
  //       .where('members', arrayContains: uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       groupList = value.docs;
  //     });
  //   });
  //   print("${groupList.length} grouplist");
  // }
  void getGroups() async {
    String currentUserEmail = _auth.currentUser!.email!;
    await _firestore.collection('group').get().then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> groups =
          value.docs.where((doc) {
        // check if currentUserEmail is present in the members list of the document
        List<Map<String, dynamic>> members =
            List<Map<String, dynamic>>.from(doc['members']);
        bool isMember =
            members.any((member) => member['email'] == currentUserEmail);
        return isMember;
      }).toList();
      setState(() {
        groupList = groups;
      });
    });
    print("${groupList.length} groups found");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchTextField(
            hintText: "Search",
            controller: _searchController,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: groupList.length,
                itemBuilder: (BuildContext context, int index) {
                  return MessageTile(
                    username: groupList[index]['groupname'],
                    imageUrl: groupList[index]['imageUrl'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => GroupChatWidget(
                            groupChatId: groupList[index]['id'],
                            groupChatName: groupList[index]['groupname'],
                            groupChatImage: groupList[index]['imageUrl'],
                          ),
                        ),
                      );
                    },
                  );
                }),
          )
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
