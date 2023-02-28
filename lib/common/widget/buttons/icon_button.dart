import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final Color iconColor;
  final Color backgroundColor;
  final double borderRadius;
  final double padding;
  const CustomIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.borderRadius = 5,
    this.padding = 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            padding: EdgeInsets.all(padding),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
