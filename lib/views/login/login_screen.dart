import 'package:flutter/material.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8.0,
            children: [
              Spacer(),
              Text(
                "Welcome Back!",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

              Spacer(),
              indigoButton(
                text: "LOG IN WITH GOOGLE",
                onPressed: () {
                  ref.read(authRepositoryProvider).signInWithGoogle();
                },
              ), //TODO
              Spacer(),
              indigoButton(
                text: "LOG IN",
                onPressed: () {
                  ref
                      .read(authRepositoryProvider)
                      .signInWithEmailAndPassword(
                        email: "jt@email.com",
                        password: "12345678",
                      );
                },
              ), //TODO
              multicolorSentence(
                text: ["FORGOT PASSWORD?"],
                colors: [SWColor.blue.color],
                style: Theme.of(context).textTheme.bodySmall,
              ),
              multicolorSentence(
                text: ["DON'T HAVE AN ACCOUNT? ", "SIGN UP"],
                colors: [null, SWColor.blue.color],
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
