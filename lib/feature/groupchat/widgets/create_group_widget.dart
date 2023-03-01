import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:forum/common/constant/textStyle.dart';
import 'package:forum/common/widget/buttons/rounded_button.dart';
import 'package:forum/common/widget/text_field/search_textfiled.dart';
import 'package:forum/feature/dashboard/screens/dashboard_screen.dart';
import 'package:forum/feature/groupchat/screens/group_info.dart';
import 'package:forum/feature/groupchat/widgets/group_info_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme.dart';
import '../../../common/widget/buttons/icon_button.dart';
import '../../../services/firebase_service.dart';
import '../../dashboard/screens/channel_screens.dart';

class CreateGroup extends StatefulWidget {
  // final List<String> members;
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> members = [];
  List<Map<String, dynamic>> users = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentUser = _auth.currentUser!.email.toString();
    FirebaseService.db
        .collection('users')
        .where('email', isNotEqualTo: currentUser)
        .get()
        .then((value) {
      setState(() {
        users = value.docs.map((doc) => doc.data()).toList();
      });
    });

    getCurrentUserDetails();
  }

  void getCurrentUserDetails() async {
    final currentUser = _auth.currentUser!.email.toString();
    print("current $currentUser");
    try {
      final userDoc = await _firestore
          .collection('users')
          .where('email', isEqualTo: currentUser)
          .limit(1)
          .get()
          .then((value) {
        if (value.size > 0) {
          final doc = value.docs[0];
          print(value.toString());
          setState(() {
            members.add({
              "email": doc['email'],
              "name": doc['username'],
              "isAdmin": true,
            });
          });
        }
      });
    } catch (e) {
      print('Error fetching user details: $e');
    }
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
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void onResultTap(dynamic selectedUser) {
    bool isMember = false;
    for (int i = 0; i < members.length; i++) {
      if (members[i]['email'] == selectedUser['email']) {
        isMember = true;
      }
    }
    if (!isMember) {
      setState(() {
        members.add({
          "email": selectedUser['email'],
          "name": selectedUser['username'],
          "isAdmin": false,
        });
        users.remove(selectedUser);
      });
    }
  }

  void onRemoveMember(int index) {
    if (members[index]['isAdmin'] == false) {
      setState(() {
        final removedMember = members[index];
        members.removeAt(index);
        users.add({
          "email": removedMember['email'],
          "username": removedMember['name'],
          "isAdmin": removedMember['isAdmin'],
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomTheme.black,
          elevation: 0.8,
          centerTitle: true,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardScreen()));
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: CustomTheme.lightTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: Container(
            padding: const EdgeInsets.only(top: 18),
            child: const Text(
              "Create Group",
              style: CustomTextStyle.appText3,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchTextField(
              hintText: "Search",
              controller: _searchController,
              onSearched: () {
                onSearched();
              },
            ),
            users != null
                ? SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final selectedUser = users[index];
                        return ListTile(
                          onTap: () => onResultTap(selectedUser),
                          leading: Icon(Icons.abc),
                          title: Text(selectedUser['username']),
                          subtitle: Text(selectedUser['email']),
                          trailing: Icon(Icons.add),
                        );
                      },
                    ),
                  )
                : SizedBox(),
            Container(
              child: const Text(
                "Members",
                style: CustomTextStyle.heading4,
              ),
            ),
            SizedBox(
              height: 460,
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      onRemoveMember(index);
                    },
                    leading: Icon(Icons.abc),
                    title: Text(members[index]['name']),
                    subtitle: Text(members[index]['email']),
                    trailing: Icon(Icons.curtains_closed_outlined),
                  );
                },
              ),
            ),
            members.length > 2
                ? Container(
                    alignment: Alignment.bottomCenter,
                    child: CustomRoundedButton(
                      title: "Next",
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroupInfoScreen(
                                      members: members,
                                    )));
                      },
                    ),
                  )
                : Container(
                    child: Text("Group should have more than 2 members"),
                  ),
          ],
        ),
      ),
    );
  }
}
