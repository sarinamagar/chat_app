import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';

import '../../constant/fonts.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
    required this.onItenSelected,
  }) : super(key: key);

  final ValueChanged<int> onItenSelected;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItenSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: false,
        bottom: true,
        child: Container(
          width: _width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationBarItem(
                index: 0,
                label: 'Messages',
                onTap: handleItemSelected,
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                isSelected: (selectedIndex == 0),
              ),
              NavigationBarItem(
                index: 1,
                label: 'Channels',
                onTap: handleItemSelected,
                icon: CupertinoIcons.chat_bubble_text_fill,
                isSelected: (selectedIndex == 1),
              ),
            ],
          ),
        ));
  }
}

class NavigationBarItem extends StatelessWidget {
  NavigationBarItem({
    super.key,
    required this.label,
    required this.icon,
    required this.index,
    required this.onTap,
    this.isSelected = false,
  });

  final ValueChanged<int> onTap;

  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 26,
              color: isSelected ? CustomTheme.black : CustomTheme.darkGray,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(label,
                style: TextStyle(
                  color: isSelected ? CustomTheme.black : CustomTheme.darkGray,
                  fontFamily: Fonts.quickSand,
                  fontSize: isSelected ? 16 : 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                )),
          ],
        ),
      ),
    );
  }
}
