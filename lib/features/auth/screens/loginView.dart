import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../controller/auth_controller.dart';
import 'signup_view.dart';
import '../../../common/common.dart';
import '../widgets/auth_field.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginView(),
      );
  const LoginView({super.key});
  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIconstants.appBar();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
        email: _userNameController.text,
        password: _passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoding = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoding ? const Loader():SafeArea(
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
                          obscureText: true,
                          controller: _passwordController,
                          hintText: "password"),
                      const SizedBox(
                        height: 70,
                      ),
                      RoundedSmallButton(
                          onTap: onLogin,
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
