import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/feature/authentication/screens/login_screen.dart';
import 'package:forum/feature/authentication/screens/register_screen.dart';

import '../../../common/tab_bar/myTabbar.dart';

const kLabels = ["Sign-In", "Sign-Up"];
const kTabBgColor = Color(0xFF0000000);
const kTabFgColor = Colors.white;

class AuthenticationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF000000)),
      home: MainTab(),
    );
  }
}

class MainTab extends HookWidget {
  const MainTab();

  @override
  Widget build(BuildContext context) {
    final _controller = useTabController(initialLength: 2);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 260,
            padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 70),
            decoration: const BoxDecoration(
              color: CustomTheme.black,
            ),
            child: Image.asset(
              "assets/images/logo.png",
              height: 90,
              width: 150,
            ),
          ),
          MyTabBar(
            controller: _controller,
            labels: kLabels,
            backgroundColor: kTabBgColor,
            foregroundColor: kTabFgColor,
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: const [
                Center(child: LoginScreens()),
                Center(child: RegisterScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
