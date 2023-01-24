// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';
import 'package:forum/common/widget/buttons/rounded_button.dart';
import 'package:forum/common/widget/text_field/custom_textfield.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({super.key});

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 14),
                child: Text(
                  "Login to Forum",
                  style: CustomTextStyle.heading1,
                ),
              ),
              Text(
                "Loren ipsum dot stiii",
                style: CustomTextStyle.subHeading,
              ),
              SizedBox(
                height: 26,
              ),
              CustomTextField(
                label: "E-Mail",
                hintText: "user@gmail.com",
                bottomPadding: 10,
                obscureText: false,
                readOnly: false,
                isRequired: true,
              ),
              CustomTextField(
                label: "Password",
                hintText: "•••••••••••",
                bottomPadding: 10,
                obscureText: true,
                readOnly: false,
                isRequired: true,
                suffixIcon: Icons.abc,
              ),
              Align(
                alignment: Alignment.centerRight,
                widthFactor: 2.5,
                child: Text(
                  "Forgot Password?",
                  style: CustomTextStyle.heading4,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: CustomRoundedButton(
                  title: "Login",
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: CustomTextStyle.heading4,
                    children: const [
                      TextSpan(
                        text: "Register",
                        style: CustomTextStyle.boldHeading4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
