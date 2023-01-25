import 'package:flutter/material.dart';
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

  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          }),
      bottomNavigationBar: BottomNavigation(
        onItenSelected: (index) {
          pageIndex.value = index;
        },
      ),
    );
  }
}
