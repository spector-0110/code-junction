import 'package:app_w/common/info_card.dart';
import 'package:app_w/features/auth/controller/auth_controller.dart';
import 'package:app_w/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = Provider(
  (ref) {
    return ref.watch(authControllerProvider.notifier).currentUser();
  },
);

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({super.key});

  @override
  ConsumerState<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 280,
        height: double.infinity,
        color: Pallete.blueColor.withOpacity(0.5),
        child: const SafeArea(
          child: Column(
            children: [
              InfoCard(username: 'Vatsa'),
            ],
          ),
        ),
      ),
    );
  }
}
