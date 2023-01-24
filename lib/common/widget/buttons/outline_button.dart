import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';

import '../../constant/fonts.dart';
import '../../constant/textStyle.dart';

class CustomBorderButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double bottomPadding;

  const CustomBorderButton({
    super.key,
    required this.title,
    this.onPressed,
    this.bottomPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 5,
        child: InkWell(
          onTap: onPressed,
          splashColor: CustomTheme.blue3,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 130),
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomTheme.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              style: CustomTextStyle.outlineButton,
            ),
          ),
        ),
      ),
    );
  }
}
