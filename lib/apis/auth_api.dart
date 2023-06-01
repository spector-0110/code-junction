import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../core/core.dart';

// when we will access user data we use model.User i.e. from appwrite/models.dart as model
// when we want to create user or signup we use account .service i.e. appwrite/appwrite
final authApiProvider = Provider((ref) {
  final account = ref.watch(appWriteAccountProvider);
  return AuthApi(
    account: account,
  );
});

abstract class IAuthApi {
  FutureEither<model.User> signUp({
    required String email,
    required String password,
  });
  FutureEither<model.Session> login({
    required String email,
    required String password,
  });
  Future<model.User?> currentUserSession();
}

class AuthApi implements IAuthApi {
  final Account _account;

  AuthApi({required Account account}) : _account = account;

  @override
  Future<model.User?> currentUserSession() async {
    try {
      return _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Exception', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'expeption while log in', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
