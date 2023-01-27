import 'package:flutter/material.dart';
import 'package:forum/common/constant/textStyle.dart';

class DateLabel extends StatelessWidget {
  const DateLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              label,
              style: CustomTextStyle.date,
            ),
          ),
        ),
      ),
    );
  }
}
