import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({
    super.key,
    required this.message,
  });
  final String message;
  static const _borderRadiusLeft = 10.0;
  static const _borderRadiusRight = 27.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: CustomTheme.divider, width: 2),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(_borderRadiusRight),
                topRight: Radius.circular(_borderRadiusRight),
                bottomRight: Radius.circular(_borderRadiusRight),
                bottomLeft: Radius.circular(_borderRadiusRight)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12.8),
            child: Text(
              message,
              style: CustomTextStyle.heading4,
            ),
          ),
        ),
      ),
    );
  }
}
