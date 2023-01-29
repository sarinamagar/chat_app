import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';
import 'package:forum/common/widget/buttons/rounded_button.dart';
import 'package:forum/common/widget/text_field/custom_textfield.dart';
import 'package:forum/feature/authentication/screens/register_screen.dart';
import 'package:forum/feature/dashboard/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../../../services/local_notification_service.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../../viewmodels/global_ui_viewmodel.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({super.key});

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureTextPassword = true;

  final _formKey = GlobalKey<FormState>();

  void login() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _ui.loadState(true);
    try {
      await _authViewModel
          .login(_emailController.text, _passwordController.text)
          .then((value) {
        NotificationService.display(
          title: "Welcome back",
          body:
              "Hello ${_authViewModel.loggedInUser?.username},\n Hope you are having a wonderful day.",
        );
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => new DashboardScreen()));
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 14),
                  child: const Text(
                    "Login to Forum",
                    style: CustomTextStyle.heading1,
                  ),
                ),
                const Text(
                  "Loren ipsum dot stiii",
                  style: CustomTextStyle.subHeading,
                ),
                const SizedBox(
                  height: 26,
                ),
                CustomTextField(
                  label: "E-Mail",
                  hintText: "user@gmail.com",
                  bottomPadding: 10,
                  obscureText: false,
                  readOnly: false,
                  isRequired: true,
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: ValidateLogin.emailValidate,
                  suffixIcon: const Icon(
                    Icons.mail,
                    color: CustomTheme.black,
                    size: 20,
                  ),
                ),
                CustomTextField(
                  label: "Password",
                  hintText: "•••••••••••",
                  bottomPadding: 10,
                  readOnly: false,
                  isRequired: true,
                  controller: _passwordController,
                  obscureText: _obscureTextPassword,
                  validator: ValidateLogin.password,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureTextPassword = !_obscureTextPassword;
                      });
                    },
                    child: Icon(
                      _obscureTextPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  widthFactor: 2.5,
                  child: Text(
                    "Forgot Password?",
                    style: CustomTextStyle.heading4,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: CustomRoundedButton(
                    title: "Login",
                    onPressed: () {
                      login();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: CustomTextStyle.heading4,
                      children: [
                        TextSpan(
                            text: "Register",
                            style: CustomTextStyle.boldHeading4,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed("/register");
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ValidateLogin {
  static String? emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }
}
