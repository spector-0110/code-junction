import 'package:app_w/constants/appwrite_constants.dart';
import 'package:app_w/core/core.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../models/models.dart';

final userApiProvider = Provider(
  (ref) {
    return UserApi(db: ref.watch(dataBaseProvider));
  },
);

abstract class IUserApi {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserApi implements IUserApi {
  final Databases _db;

  UserApi({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
          databaseId: AppWriteConstants.dataBaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId: userModel.id,
          data: userModel.toMap());
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(
          e.message ?? "some error occured",
          stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
