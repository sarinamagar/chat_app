import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum/common/widget/buttons/rounded_button.dart';
import 'package:forum/common/widget/text_field/custom_textfield.dart';
import 'package:forum/feature/dashboard/screens/dashboard_screen.dart';
import 'package:forum/feature/groupchat/screens/create_group.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme.dart';
import '../../../common/constant/textStyle.dart';

class GroupInfoWidget extends StatefulWidget {
  final List<Map<String, dynamic>> members;
  GroupInfoWidget({super.key, required this.members});

  @override
  State<GroupInfoWidget> createState() => _GroupInfoWidgetState();
}

class _GroupInfoWidgetState extends State<GroupInfoWidget> {
  final TextEditingController _groupName = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  void createGroup() async {
    setState(() {
      isLoading = true;
    });

    String groupId = Uuid().v1();

    try {
      await _firestore.collection('group').doc(groupId).set({
        "members": widget.members,
        "id": groupId,
        "groupname": _groupName.text,
      });

      if (widget.members != null && widget.members.isNotEmpty) {
        for (int i = 0; i < widget.members.length; i++) {
          String uid = widget.members[i]['username'];
          await _firestore
              .collection('users')
              .doc(uid)
              .collection('group')
              .doc(uid)
              .set({
            "name": _groupName.text,
            "id": groupId,
          });
        }
      }

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DashboardScreen()));
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                                builder: (context) =>
                                    const CreateGroupScreen()));
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
      body: isLoading
          ? Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: CustomTheme.black,
              ),
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: _groupName,
                    readOnly: false,
                    bottomPadding: 12,
                    hintText: 'Group Name',
                    isRequired: true,
                    label: 'Group Name',
                    obscureText: false,
                  ),
                ),
                CustomRoundedButton(
                  title: "Create",
                  onPressed: () {
                    createGroup();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => DashboardScreen()));
                  },
                ),
              ],
            ),
    );
  }
}
