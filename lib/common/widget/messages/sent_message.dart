import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../constant/textStyle.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.message});
  final String message;
  static const _borderRadiusLeft = 10.0;
  static const _borderRadiusRight = 27.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: const BoxDecoration(
            color: CustomTheme.black,
            // border: Border.all(color: CustomTheme.date, width: 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_borderRadiusRight),
                topRight: Radius.circular(_borderRadiusRight),
                bottomRight: Radius.circular(_borderRadiusLeft),
                bottomLeft: Radius.circular(_borderRadiusRight)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12.8),
            child: Text(
              message,
              style: CustomTextStyle.heading4W,
            ),
          ),
        ),
      ),
    );
  }
}
