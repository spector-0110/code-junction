import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/auth_api.dart';
import '../widgets/coustom_snackBar.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(
      authApi: ref.watch(authApiProvider),
    );
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  AuthController({required AuthApi authApi})
      : _authApi = authApi,
        super(false);

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.signUp(email: email, password: password);
    res.fold(
      (l) => snackBar(l.message, context),
      (r) => print(r.email),
    );
  }
}
