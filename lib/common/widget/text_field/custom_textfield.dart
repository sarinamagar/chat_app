import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextInputType? textInputType;
  final double bottomPadding;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool isRequired;
  final VoidCallback? onPressed;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.textInputType,
    required this.bottomPadding,
    required this.obscureText,
    required this.readOnly,
    this.suffixIcon,
    this.controller,
    this.validator,
    required this.isRequired,
    this.onPressed,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: widget.bottomPadding, top: widget.bottomPadding, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 1,
            shadowColor: CustomTheme.shadowColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: TextFormField(
              obscureText: widget.obscureText,
              validator: widget.validator,
              controller: widget.controller,
              keyboardType: TextInputType.text,
              cursorColor: CustomTheme.darkGray,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: CustomTextStyle.hintText,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                fillColor: CustomTheme.primaryColor,
                filled: true,
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: CustomTheme.darkGray)),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: CustomTheme.darkGray)),
                labelText: widget.label,
                labelStyle: CustomTextStyle.labelText,
                suffixIcon: widget.suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
