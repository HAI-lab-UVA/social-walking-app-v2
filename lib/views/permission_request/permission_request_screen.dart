import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/repositories/user_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';

class PermissionRequestScreen extends ConsumerStatefulWidget {
  const PermissionRequestScreen({super.key});

  @override
  ConsumerState<PermissionRequestScreen> createState() =>
      _PermissionRequestScreenState();
}

class _PermissionRequestScreenState
    extends ConsumerState<PermissionRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8.0,
          children: [
            Spacer(),
            Text("PERMISSION REQUEST (WIP)"),
            customButton(
              text: "FINISH SETUP",
              onPressed: () async {
                final uid = ref.read(authRepositoryProvider).getCurrentUserId();
                await ref
                    .read(userRepositoryProvider)
                    .finishUserSetup(uid: uid);
                if (mounted) {
                  context.go("/home");
                }
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
