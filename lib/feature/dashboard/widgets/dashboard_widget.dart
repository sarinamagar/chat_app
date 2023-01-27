import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';
import 'package:forum/common/widget/navigationBar/bottom_navigation.dart';
import 'package:forum/feature/dashboard/screens/channel_screens.dart';
import 'package:forum/feature/dashboard/screens/messages_screens.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
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
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: CustomTheme.black,
          elevation: 0.8,
          centerTitle: true,
          title: ValueListenableBuilder(
              valueListenable: pageTitle,
              builder: (BuildContext context, String value, _) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
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
