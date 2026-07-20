import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/repositories/user_repository.dart';

class AuthCheckScreen extends ConsumerStatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  ConsumerState<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends ConsumerState<AuthCheckScreen> {
  Future<void> authCheck() async {
    if (!mounted) return;

    final userAccountCreated = await ref
        .read(userRepositoryProvider)
        .currentUserExists();
    if (userAccountCreated) {
      final currentUser = await ref
          .read(userRepositoryProvider)
          .getCurrentUser()
          .first;
      if (currentUser.finishedSetup) {
        context.go("/home");
      } else {
        context.go("/onboarding");
      }
    } else {
      context.go("/onboarding");
    }
  }

  @override
  void initState() {
    authCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
