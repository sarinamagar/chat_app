import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';
import 'package:forum/common/widget/buttons/icon_button.dart';
import 'package:forum/common/widget/navigationBar/bottom_navigation.dart';
import 'package:forum/feature/authentication/screens/login_screen.dart';
import 'package:forum/feature/dashboard/screens/channel_screens.dart';
import 'package:forum/feature/dashboard/screens/messages_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/firebase_service.dart';
import '../../authentication/screens/authentication_screen.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  final pages = [
    const MessagesScreen(),
    const ChannelScreen(),
  ];
  final pagesTitle = [
    "Inbox",
    "Channel",
  ];
  void OnNavigationItemSelected(index) {
    pageTitle.value = pagesTitle[index];
    pageIndex.value = index;
  }

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> pageTitle = ValueNotifier("Inbox");

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: CustomTheme.black,
          elevation: 0.8,
          centerTitle: true,
          title: ValueListenableBuilder(
              valueListenable: pageTitle,
              builder: (BuildContext context, String value, _) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.only(top: 35),
                  child: Text(
                    value,
                    style: CustomTextStyle.appText,
                  ),
                );
              }),
          flexibleSpace: Container(
            margin: const EdgeInsets.only(right: 300, bottom: 4),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.contain)),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: CustomTheme.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 80,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    user?.email ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthenticationScreen()),
                  );
                } catch (err) {
                  print('Error logging out: $err');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                // handle help button press
              },
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          }),
      bottomNavigationBar: BottomNavigation(
        onItenSelected: OnNavigationItemSelected,
      ),
    );
  }
}
