import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';

// client is important because its necessary for making api calls to appwrite
final appwriteClientProvider = Provider(
  (ref) {
    Client client = Client();
    return client
        .setEndpoint(AppWriteConstants.endPoint)
        .setProject(AppWriteConstants.projectId)
        .setSelfSigned(status: true);
  },
);

final appWriteAccountProvider = Provider(
  (ref) {
    final client = ref.watch(appwriteClientProvider);
    return Account(client);
  },
);

final dataBaseProvider = Provider(
  (ref) {
    final client = ref.watch(appwriteClientProvider);
    return Databases(client);
  },
);
