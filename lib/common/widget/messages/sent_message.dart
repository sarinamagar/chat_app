import 'package:flutter/material.dart';
import 'package:forum/common/widget/messages/date_label.dart';

import '../../../app/theme.dart';
import '../../constant/textStyle.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.message, required this.time});
  final String message;
  final String time;
  static const _borderRadiusRight = 27.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // time != "" ? DateLabel(label: time) : Container(),
        Padding(
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
                    bottomRight: Radius.circular(_borderRadiusRight),
                    bottomLeft: Radius.circular(_borderRadiusRight)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12.8),
                child: Text(
                  message,
                  style: CustomTextStyle.heading4W,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
