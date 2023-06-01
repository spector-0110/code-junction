import 'package:app_w/features/auth/screens/loginView.dart';
import 'package:app_w/features/home/screens/home_view.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/auth_api.dart';
import '../../../common/common.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(
      authApi: ref.watch(authApiProvider),
    );
  },
);

final currentUserProvider = FutureProvider(
  (ref) async {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController;
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  AuthController({required AuthApi authApi})
      : _authApi = authApi,
        super(false);

  Future<model.User?> currentUser() => _authApi.currentUserSession();

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.signUp(email: email, password: password);
    state = false;
    res.fold(
      (l) => snackBar(l.message, context),
      (r) {
        snackBar('Account Created Succesfully ! Please Log In', context);
        Navigator.of(context).pushReplacement(
          LoginView.route(),
        );
      },
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.login(email: email, password: password);
    state = false;
    res.fold(
      (l) => snackBar(l.message, context),
      (r) {
        Navigator.of(context).push(
          HomeScreen.route(),
        );
      },
    );
  }
}
