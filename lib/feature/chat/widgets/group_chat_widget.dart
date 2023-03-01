import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../../../app/theme.dart';
import '../../../common/constant/textStyle.dart';
import '../../../common/widget/messages/date_label.dart';
import '../../../common/widget/messages/received_message.dart';
import '../../../common/widget/messages/sent_message.dart';
import '../../../common/widget/text_field/message_textfield.dart';
import '../../../common/widget/text_field/search_textfiled.dart';

class GroupChatWidget extends StatefulWidget {
  final String groupChatId;
  final String groupChatName;
  final String groupChatImage;
  const GroupChatWidget(
      {super.key,
      required this.groupChatId,
      required this.groupChatName,
      required this.groupChatImage});

  @override
  State<GroupChatWidget> createState() => _GroupChatWidgetState();
}

class _GroupChatWidgetState extends State<GroupChatWidget> {
  File? imageFile;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _message = TextEditingController();

  Future getImage() async {
    ImagePicker _imagepicker = ImagePicker();

    await _imagepicker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = const Uuid().v1();
    int status = 1;
    String userName = _auth.currentUser!.email.toString();
    await _firestore
        .collection('group')
        .doc(widget.groupChatId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": userName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });
    var ref = FirebaseStorage.instance.ref();
    var folderRef = ref.child('images');
    var fileRef = folderRef.child("$fileName.jpg");
    var uploadTask =
        await fileRef.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('group')
          .doc(widget.groupChatId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await _firestore
          .collection('group')
          .doc(widget.groupChatId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});
      print(imageUrl);
    }
  }

  void onSendMessage() async {
    print('onSendMessage called');
    if (_message.text.isNotEmpty) {
      String userName = _auth.currentUser!.email.toString();
      Map<String, dynamic> messages = {
        "sendby": userName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      await _firestore
          .collection('group')
          .doc(widget.groupChatId)
          .collection('chats')
          .add(messages);
      _message.clear();
    } else {
      print("${_message.text} messssssssss");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomTheme.black,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: CustomTheme.divider,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomTheme.primaryColor,
                    backgroundImage: NetworkImage(widget.groupChatImage),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.groupChatName,
                          style: CustomTextStyle.appText2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          "Online",
                          style: CustomTextStyle.date,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.settings,
                    color: CustomTheme.divider,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _height / 1.25,
              width: _width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('group')
                    .doc(widget.groupChatId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return Builder(builder: (context) {
                      Map<String, bool> data = {};
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> map =
                                snapshot.data?.docs[index].data()
                                    as Map<String, dynamic>;

                            Timestamp timestamp = map['time'];
                            final DateFormat formatter = DateFormat('HH:mm');
                            final DateTime dateTime = timestamp.toDate();
                            String dateString = "";
                            bool time = dateTime.minute % 5 == 0 ? true : false;

                            dateString = formatter.format(dateTime);

                            if (time && data[dateString] == null) {
                              data[dateString] = true;
                              map["showDate"] = true;
                            } else {
                              map["showDate"] = false;
                            }

                            return messages(size, map);
                          });
                    });
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: _height / 10,
              width: _width,
              alignment: Alignment.center,
              child: MessageTextField(
                sendMessage: onSendMessage,
                controller: _message,
                sendImage: getImage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> userMap) {
    Timestamp timestamp = userMap['time'];
    final DateFormat formatter = DateFormat('HH:mm');
    final DateTime dateTime = timestamp.toDate();
    String dateString = "";

    bool time = dateTime.minute % 5 == 0 ? true : false;

    if (time) {
      dateString = formatter.format(dateTime);
    }
    String a = userMap['sendby'].toString().replaceAll("@gmail.com", "");
    return userMap['type'] == "text"
        ? Column(
            children: [
              userMap["showDate"] == true
                  ? DateLabel(label: dateString)
                  : Container(),
              Container(
                width: size.width,
                child: userMap['sendby'] == _auth.currentUser?.email.toString()
                    ? Column(
                        children: [
                          SentMessage(
                            message: userMap['message'],
                            time: dateString.toString(),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 18),
                            alignment: Alignment.centerRight,
                            child: Text(
                              "$a",
                              style: CustomTextStyle.name,
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          ReceivedMessage(message: userMap['message']),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "$a",
                              style: CustomTextStyle.name2,
                            ),
                          )
                        ],
                      ),
              ),
            ],
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            alignment: userMap['sendby'] == _auth.currentUser?.email.toString()
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height / 2.5,
                  width: size.width / 2,
                  alignment: Alignment.center,
                  child: userMap['message'] != ""
                      ? Image.network(userMap['message'])
                      : const CircularProgressIndicator(),
                ),
              ],
            ),
          );
  }
}
