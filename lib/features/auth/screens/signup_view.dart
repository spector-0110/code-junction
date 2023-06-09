import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_field.dart';
import '../../../common/common.dart';
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
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : SafeArea(
              child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: const AssetImage(AssestConstants.appBgWhite),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Pallete.backgroundColor.withOpacity(.14),
                        Pallete.blueColor.withOpacity(.07),
                        Pallete.backgroundColor.withOpacity(.25)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Form(
                          child: Column(
                            children: [
                              AuthField(
                                  controller: _userNameController,
                                  hintText: "Email"),
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
                                  onTap: onSignUp, label: "SignUp "),
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
                                          Navigator.pop(context);
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
                ),
              ],
            )),
    );
  }
}
