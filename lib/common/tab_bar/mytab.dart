import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/fonts.dart';
import 'package:forum/common/tab_bar/tabPainter.dart';
import 'dart:math' as math;

class MyTab extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color activeBackgroundColor;
  final Color activeForegroundColor;
  final double fontSize;
  final bool active;
  final bool reversed;
  final String label;
  final VoidCallback onTap;

  Color get bgColor =>
      active ? activeBackgroundColor ?? foregroundColor : backgroundColor;
  Color get fgColor =>
      active ? activeForegroundColor ?? backgroundColor : foregroundColor;

  const MyTab({
    this.active = true,
    this.reversed = false,
    this.label = "Demo",
    this.backgroundColor = CustomTheme.primaryColor,
    this.foregroundColor = CustomTheme.black,
    this.activeBackgroundColor = CustomTheme.black,
    this.activeForegroundColor = CustomTheme.black,
    this.fontSize = 8,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: reversed
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: CustomPaint(painter: TabPainter(color: bgColor)),
                  )
                : CustomPaint(painter: TabPainter(color: bgColor)),
          ),
        ),
        Align(
          alignment: reversed ? Alignment.centerRight : Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: .5,
            heightFactor: 1,
            child: TextButton(
              onPressed: active ? null : onTap,
              child: Text(
                label,
                style: TextStyle(
                  color: fgColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  fontFamily: Fonts.quickSand,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
