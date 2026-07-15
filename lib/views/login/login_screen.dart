import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/repositories/user_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? emailErrorText = "";
  String? googleErrorText = "";
  bool isProcessingLogin = false;

  void handleSignInWithEmail() async {
    if (!isProcessingLogin) {
      setState(() {
        emailErrorText = "";
        isProcessingLogin = true;
      });
      if (formKey.currentState!.validate()) {
        final email = emailController.text;
        final password = passwordController.text;
        final status = await ref
            .read(authRepositoryProvider)
            .signInWithEmailAndPassword(email: email, password: password);

        if (status.success) {
          final String uid = status.content;
          final userExists = await ref
              .read(userRepositoryProvider)
              .userExists(uid);
          if (userExists) {
            if (mounted) {
              context.go("/home");
            }
          } else {
            if (mounted) {
              context.go("/onboarding");
            }
          }
        } else {
          setState(() {
            emailErrorText = status.content;
            isProcessingLogin = false;
          });
        }
      } else {
        setState(() {
          isProcessingLogin = false;
        });
      }
    }
  }

  void handleSignInWithGoogle() async {
    if (!isProcessingLogin) {
      setState(() {
        googleErrorText = "";
        isProcessingLogin = true;
      });
      final status = await ref.read(authRepositoryProvider).signInWithGoogle();

      if (status.success) {
        final String uid = status.content.uid;
        final userExists = await ref
            .read(userRepositoryProvider)
            .userExists(uid);
        if (userExists) {
          if (mounted) {
            context.go("/home");
          }
        } else {
          if (mounted) {
            context.go("/onboarding");
          }
        }
      } else {
        setState(() {
          googleErrorText = status.content;
          isProcessingLogin = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
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
              if (!isKeyboardOpen)
                googleButton(
                  text: "LOG IN WITH GOOGLE",
                  onPressed: handleSignInWithGoogle,
                ),
              if (googleErrorText != null && googleErrorText != "")
                Text(
                  googleErrorText!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: SWColor.red),
                  textAlign: TextAlign.center,
                ),
              Spacer(),

              Text(
                "OR LOG IN WITH EMAIL",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              Form(
                key: formKey,
                child: Column(
                  spacing: 8.0,
                  children: [
                    textInputField(
                      hintText: "EMAIL",
                      controller: emailController,
                      context: context,
                      validator: (value) {
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

                        if (value == null || value == "") {
                          return "Email cannot be empty.";
                        } else if (!emailRegex.hasMatch(value)) {
                          return "Please enter a valid email.";
                        }
                        return null;
                      },
                    ),
                    textInputField(
                      hintText: "PASSWORD",
                      controller: passwordController,
                      context: context,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Password cannot be empty.";
                        }
                        return null;
                      },
                      isObscured: true,
                    ),

                    if (emailErrorText != null && emailErrorText != "")
                      Text(
                        emailErrorText!,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.copyWith(color: SWColor.red),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
              customButton(text: "LOG IN", onPressed: handleSignInWithEmail),
              Text(
                "FORGOT PASSWORD?",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: SWColor.blueLight),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () => context.go("/signup"),
                child: multiColorSentence(
                  text: ["DON'T HAVE AN ACCOUNT? ", "SIGN UP"],
                  colors: [null, SWColor.blueLight],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
