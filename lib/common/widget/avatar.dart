import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 22,
      backgroundColor: CustomTheme.blue3,
    );
  }
}
