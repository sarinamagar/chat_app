import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forum/common/widget/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import '../../../app/theme.dart';
import '../../../common/constant/textStyle.dart';
import '../../../common/widget/buttons/rounded_button.dart';
import '../../../common/widget/text_field/custom_textfield.dart';
import '../../../model/user_model.dart';
import '../../../services/local_notification_service.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../../viewmodels/global_ui_viewmodel.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextPasswordConfirm = true;

  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;

  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  void register() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _ui.loadState(true);
    try {
      await _auth
          .register(UserModel(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
      ))
          .then((value) {
        NotificationService.display(
          title: "Welcome to this app",
          body:
              "Hello ${_auth.loggedInUser?.username},\n Thank you for registering in this application.",
        );
        Navigator.of(context).pushReplacementNamed("/dashboard");
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

  final _formKey = GlobalKey<FormState>();
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
                    "Register to Forum",
                    style: CustomTextStyle.heading1,
                  ),
                ),
                const Text(
                  "Loren ipsum dot stiii",
                  style: CustomTextStyle.subHeading,
                ),
                const SizedBox(
                  height: 0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  alignment: Alignment.center,
                  child: DottedBorder(
                    borderType: BorderType.Circle,
                    strokeWidth: 2,
                    dashPattern: const [6],
                    color: CustomTheme.darkGray,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(36),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconButton(
                          icon: Icons.image_outlined,
                          iconColor: CustomTheme.primaryColor,
                          backgroundColor: CustomTheme.black,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  label: "UserName",
                  hintText: "user_name123",
                  bottomPadding: 10,
                  obscureText: false,
                  readOnly: false,
                  isRequired: true,
                  controller: _usernameController,
                  validator: ValidateSignup.username,
                ),
                CustomTextField(
                  label: "E-Mail",
                  hintText: "user@gmail.com",
                  bottomPadding: 10,
                  obscureText: false,
                  readOnly: false,
                  isRequired: true,
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: ValidateSignup.emailValidate,
                ),
                CustomTextField(
                  label: "Password",
                  hintText: "•••••••••••",
                  bottomPadding: 10,
                  readOnly: false,
                  isRequired: true,
                  controller: _passwordController,
                  obscureText: _obscureTextPassword,
                  validator: (String? value) => ValidateSignup.password(
                      value, _confirmPasswordController),
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
                CustomTextField(
                  label: "Confirm Password",
                  hintText: "•••••••••••",
                  bottomPadding: 10,
                  readOnly: false,
                  isRequired: true,
                  controller: _confirmPasswordController,
                  obscureText: _obscureTextPasswordConfirm,
                  validator: (String? value) =>
                      ValidateSignup.password(value, _passwordController),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureTextPasswordConfirm =
                            !_obscureTextPasswordConfirm;
                      });
                    },
                    child: Icon(
                      _obscureTextPasswordConfirm
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: CustomRoundedButton(
                    title: "Register",
                    onPressed: () {
                      register();
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 6, bottom: 50),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: CustomTextStyle.heading4,
                      children: [
                        TextSpan(
                          text: "Login",
                          style: CustomTextStyle.boldHeading4,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed("/login");
                            },
                        ),
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

class ValidateSignup {
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String? emailValidate(String? value) {
    final RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!emailValid.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required";
    }
    return null;
  }

  static String? password(String? value, TextEditingController otherPassword) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password should be at least 8 character";
    }
    if (otherPassword.text != value) {
      return "Please make sure both the password are the same";
    }
    return null;
  }
}
