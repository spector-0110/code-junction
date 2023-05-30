import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_field.dart';
import '../widgets/rounded_buttom.dart';
import 'loginView.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIconstants.appBar();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
        email: _userNameController.text,
        password: _passwordController.text,
        context: context);
  }

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
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
              ),
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
                  Icons.code,
                  size: 150,
                ),
                const SizedBox(
                  height: 80,
                ),
                Form(
                  child: Column(
                    children: [
                      AuthField(
                          controller: _userNameController, hintText: "Email"),
                      const SizedBox(
                        height: 23,
                      ),
                      AuthField(
                          controller: _passwordController,
                          hintText: "password"),
                      const SizedBox(
                        height: 70,
                      ),
                      RoundedSmallButton(onTap: onSignUp, label: "SignUp "),
                      const SizedBox(
                        height: 40,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Already have an account ?",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: '  Log in',
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    LoginView.route(),
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
