import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:forum/common/widget/buttons/rounded_button.dart';
import 'package:forum/common/widget/text_field/custom_textfield.dart';
import 'package:forum/feature/dashboard/screens/dashboard_screen.dart';
import 'package:forum/feature/groupchat/screens/create_group.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme.dart';
import '../../../common/constant/textStyle.dart';
import '../../../common/widget/buttons/icon_button.dart';

class GroupInfoWidget extends StatefulWidget {
  final List<Map<String, dynamic>> members;
  GroupInfoWidget({super.key, required this.members});

  @override
  State<GroupInfoWidget> createState() => _GroupInfoWidgetState();
}

class _GroupInfoWidgetState extends State<GroupInfoWidget> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _groupName = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  File? imageFile;
  String imageUrl = "";

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
        "imageUrl": imageUrl,
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
      await _firestore
          .collection('group')
          .doc(groupId)
          .collection('chats')
          .add({
        "message": "${_auth.currentUser?.displayName} Created this Group",
        "type": "notify"
      });
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Group ${_groupName.text} has been successfully created!'),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DashboardScreen()));
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  String url = "";

  Future<String> takeImageFromCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    Reference ref =
        FirebaseStorage.instance.ref().child("profilepics/${Uuid().v4()}.jpg");
    await ref.putFile(File(image!.path));
    String _url = await ref.getDownloadURL();
    setState(() {
      imageUrl = _url;
    });
    return _url;
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
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  alignment: Alignment.center,
                  child: DottedBorder(
                    borderType: BorderType.Circle,
                    strokeWidth: 2,
                    dashPattern: const [6],
                    color: CustomTheme.darkGray,
                    child: InkWell(
                      onTap: () {
                        takeImageFromCamera();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(22),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconButton(
                          icon: Icons.image_outlined,
                          iconColor: CustomTheme.primaryColor,
                          backgroundColor: CustomTheme.black,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    label: "GroupName",
                    hintText: "groupname",
                    bottomPadding: 10,
                    obscureText: false,
                    readOnly: false,
                    isRequired: true,
                    controller: _groupName,
                    suffixIcon: const Icon(
                      Icons.group_add_rounded,
                      color: CustomTheme.black,
                    ),
                  ),
                ),
                CustomRoundedButton(
                  title: "Create",
                  onPressed: () {
                    createGroup();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Group ${_groupName.text} has been successfully created!'),
                    ));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => DashboardScreen()));
                  },
                ),
              ],
            ),
    );
  }
}
