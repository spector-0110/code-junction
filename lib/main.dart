import 'package:app_w/features/auth/controller/auth_controller.dart';
import 'package:app_w/features/home/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/screens/loginView.dart';
import 'theme/theme.dart';
import 'package:app_w/common/common.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: AppTheme.theme,
      title: "Code Junction",
      debugShowCheckedModeBanner: false,
      home: ref.watch(currentUserProvider).when(
            data: (user) {
              //  ignore: unnecessary_null_comparison
              if (user != null) {
                return const HomeScreen();
              }
              return const LoginView();
            },
            error: (e, stackTrace) => ErrorPage(error: e.toString()),
            loading: () => const LoadingPage(),
          ),
    );
  }
}
