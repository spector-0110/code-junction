import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../core/core.dart';

// when we will access user data we use model.Account i.e. from appwrite/models.dart
// when we want to create user or signup we use account .service i.e. appwrite/appwrite
final authApiProvider = Provider((ref) {
  final account = ref.watch(appWriteAccountProvider);
  return AuthApi(
    account: account,
  );
});

abstract class IAuthApi {
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  });
}

class AuthApi implements IAuthApi {
  final Account _account;

  AuthApi({required Account account}) : _account = account;

  @override
  FutureEither<model.Account> signUp({
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
}
