import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../widgets/auth_field.dart';
import '../widgets/rounded_buttom.dart';
import 'signup_view.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginView(),
      );
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appbar = UIconstants.appBar();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage(AssestConstants.appBgWhite),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                Pallete.greyColor.withOpacity(0.2),
                Pallete.blueColor.withOpacity(.04)
              ], focalRadius: 2),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                const Icon(
                  Icons.lock,
                  size: 150,
                ),
                const SizedBox(
                  height: 80,
                ),
                Form(
                  child: Column(
                    children: [
                      AuthField(
                          controller: _userNameController,
                          hintText: "Email / User Name"),
                      const SizedBox(
                        height: 23,
                      ),
                      AuthField(
                          controller: _passwordController,
                          hintText: "password"),
                      const SizedBox(
                        height: 70,
                      ),
                      RoundedSmallButton(
                          onTap: () {},
                          label: "Log In ",
                          backgroundColor: Pallete.whiteColor),
                      const SizedBox(
                        height: 40,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Create new account ?",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: '  Sign Up',
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    SignUpView.route(),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
