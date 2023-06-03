import 'package:app_w/apis/user_api.dart';
import 'package:app_w/features/auth/screens/loginView.dart';
import 'package:app_w/features/home/screens/home_view.dart';
import 'package:app_w/models/user_model.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../apis/auth_api.dart';
import '../../../common/common.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(
      authApi: ref.watch(authApiProvider),
      userApi: ref.watch(userApiProvider),
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
  final UserApi _userApi;
  AuthController({required AuthApi authApi, required UserApi userApi})
      : _authApi = authApi,
        _userApi = userApi,
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
      (r) async {
        UserModel userModel = UserModel(
            email: email,
            name: userNameFromEmail(email),
            bio: '',
            id: r.$id,
            profilePic: '');
        final res2 = await _userApi.saveUserData(userModel);
        res2.fold(
          (l) {
            snackBar(l.message, context);
          },
          (r) {
            snackBar('Account Created Succesfully ! Please Log In', context);
            Navigator.of(context).pushReplacement(
              LoginView.route(),
            );
          },
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
