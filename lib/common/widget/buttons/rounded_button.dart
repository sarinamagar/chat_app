import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.bottomPadding = 16,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: Material(
        color: CustomTheme.black,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
          splashColor: CustomTheme.blue3.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 125),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              title,
              style: CustomTextStyle.roundedButton,
            ),
          ),
        ),
      ),
    );
  }
}
