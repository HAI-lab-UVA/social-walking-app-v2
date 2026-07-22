import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        customButton(
          text: "LOGOUT",
          onPressed: () async {
            await ref.read(authRepositoryProvider).signOut();
            if (mounted) {
              context.go("/");
            }
          },
        ),
      ],
    );
  }
}
