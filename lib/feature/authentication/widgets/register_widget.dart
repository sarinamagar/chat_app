import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../common/constant/textStyle.dart';
import '../../../common/widget/buttons/rounded_button.dart';
import '../../../common/widget/text_field/custom_textfield.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
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
                margin: const EdgeInsets.only(top: 20, bottom: 14),
                child: const Text(
                  "Register to Forum",
                  style: CustomTextStyle.heading1,
                ),
              ),
              const Text(
                "Loren ipsum dot stiii",
                style: CustomTextStyle.subHeading,
              ),
              const SizedBox(
                height: 25,
              ),
              const CustomTextField(
                label: "UserName",
                hintText: "user_name123",
                bottomPadding: 10,
                obscureText: false,
                readOnly: false,
                isRequired: true,
              ),
              const CustomTextField(
                label: "E-Mail",
                hintText: "user@gmail.com",
                bottomPadding: 10,
                obscureText: false,
                readOnly: false,
                isRequired: true,
                textInputType: TextInputType.emailAddress,
              ),
              const CustomTextField(
                label: "Password",
                hintText: "•••••••••••",
                bottomPadding: 10,
                obscureText: true,
                readOnly: false,
                isRequired: true,
                suffixIcon: Icons.abc,
              ),
              const CustomTextField(
                label: "Confirm Password",
                hintText: "•••••••••••",
                bottomPadding: 10,
                obscureText: true,
                readOnly: false,
                isRequired: true,
                suffixIcon: Icons.abc,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: CustomRoundedButton(
                  title: "Register",
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6, bottom: 50),
                child: RichText(
                  text: const TextSpan(
                    text: "Already have an account? ",
                    style: CustomTextStyle.heading4,
                    children: [
                      TextSpan(
                        text: "Login",
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
