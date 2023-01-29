import 'dart:io';
import 'package:forum/common/widget/messages/messages.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';
import 'package:forum/common/widget/messages/received_message.dart';
import 'package:forum/common/widget/messages/sent_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../common/widget/messages/date_label.dart';
import '../../../common/widget/text_field/message_textfield.dart';

class ChatWidgets extends StatelessWidget {
  ChatWidgets(
      {super.key,
      required this.users,
      required this.chatRoomId,
      required this.selectedUsername});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<Map<String, dynamic>> users;
  final String chatRoomId;
  final String selectedUsername;
  File? imageFile;

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
        .collection('chatroom')
        .doc(chatRoomId)
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
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});
      print(imageUrl);
    }
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      String userName = _auth.currentUser!.email.toString();
      Map<String, dynamic> messages = {
        "sendby": userName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
      _message.clear();
    } else {
      //print("enter your text");
      print(_message.text);
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
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomTheme.primaryColor,
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
                          selectedUsername,
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
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    // List<ChatMessage> messages = [];
                    // for (var doc in snapshot.data!.documents) {
                    //   messages.add(ChatMessage(
                    //     time: doc.data()['time'],
                    //     message: doc.data()['message'],
                    //   ));
                    // }
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map = snapshot.data?.docs[index]
                              .data() as Map<String, dynamic>;
                          return messages(size, map);
                        });
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: _height / 12,
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
    print(dateTime.minute % 5 == 0);
    String? dateString =
        dateTime.minute % 10 == 0 ? formatter.format(dateTime) : null;
    // String dateString = formatter.format(dateTime);
    return userMap['type'] == "text"
        ? Column(
            children: [
              dateString != null ? DateLabel(label: dateString) : Container(),
              Container(
                width: size.width,
                child: userMap['sendby'] == _auth.currentUser?.email.toString()
                    ? SentMessage(
                        message: userMap['message'],
                        time: dateString.toString(),
                      )
                    : ReceivedMessage(message: userMap['message']),
              ),
            ],
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            alignment: userMap['sendby'] == _auth.currentUser?.email.toString()
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: size.height / 2.5,
              width: size.width / 2,
              alignment: Alignment.center,
              child: userMap['message'] != ""
                  ? Image.network(userMap['message'])
                  : const CircularProgressIndicator(),
            ),
          );
  }
}
//   Widget messages(Size size, Map<String, dynamic> userMap) {
//     Timestamp timestamp = userMap['time'];
//     print("userMap.length ${userMap.length}");
//     final DateFormat formatter = DateFormat('HH:mm');
//     final DateTime dateTime = timestamp.toDate();
//     String dateString = formatter.format(dateTime);

//     bool _showTimestamp = true;

//     return userMap['type'] == "text"
//         ? Column(
//             children: [
//               Container(
//                 width: size.width,
//                 child: userMap['sendby'] == _auth.currentUser?.email.toString()
//                     ? SentMessage(
//                         message: userMap['message'],
//                         time: _showTimestamp ? dateString : "",
//                       )
//                     : ReceivedMessage(message: userMap['message']),
//               ),
//             ],
//           )
//         : Container(
//             height: size.height / 2.5,
//             width: size.width,
//             alignment: userMap['sendby'] == _auth.currentUser?.email.toString()
//                 ? Alignment.centerRight
//                 : Alignment.centerLeft,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               height: size.height / 2.5,
//               width: size.width / 2,
//               alignment: Alignment.center,
//               child: userMap['message'] != ""
//                   ? Image.network(userMap['message'])
//                   : const CircularProgressIndicator(),
//             ),
//           );
//   }
// }
