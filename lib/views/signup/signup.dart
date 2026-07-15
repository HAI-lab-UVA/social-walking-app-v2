import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/repositories/user_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? emailErrorText = "";
  String? googleErrorText = "";
  bool isProcessingSignup = false;

  void handleSignUpWithEmail() async {
    if (!isProcessingSignup) {
      setState(() {
        emailErrorText = "";
        isProcessingSignup = true;
      });
      if (formKey.currentState!.validate()) {
        final email = emailController.text;
        final password = passwordController.text;
        final status = await ref
            .read(authRepositoryProvider)
            .signUpWithEmailAndPassword(email: email, password: password);

        if (status.success) {
          if (mounted) {
            context.go("/onboarding");
          }
        } else {
          setState(() {
            emailErrorText = status.content;
            isProcessingSignup = false;
          });
        }
      } else {
        setState(() {
          isProcessingSignup = false;
        });
      }
    }
  }

  void handleSignUpWithGoogle() async {
    if (!isProcessingSignup) {
      setState(() {
        googleErrorText = "";
        isProcessingSignup = true;
      });
      final status = await ref.read(authRepositoryProvider).signInWithGoogle();

      if (status.success) {
        final String uid = status.content.uid;
        final userExists = await ref
            .read(userRepositoryProvider)
            .userExists(uid);
        if (userExists) {
          if (mounted) {
            context.go("/home/$uid");
          }
        } else {
          if (mounted) {
            context.go("/onboarding");
          }
        }
      } else {
        setState(() {
          googleErrorText = status.content;
          isProcessingSignup = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                "Create Your Account",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Spacer(),
              googleButton(
                text: "SIGN UP WITH GOOGLE",
                onPressed: handleSignUpWithGoogle,
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
                "OR SIGN UP WITH EMAIL",
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
                        } else if (int.parse(value) < 8) {
                          return "Password must be at least 8 characters.";
                        }
                        return null;
                      },
                      isObscured: true,
                    ),

                    textInputField(
                      hintText: "CONFIRM PASSWORD",
                      controller: passwordConfirmController,
                      context: context,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Passwords do not match.";
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
              customButton(text: "SIGN UP", onPressed: handleSignUpWithEmail),

              GestureDetector(
                onTap: () => context.go("/login"),
                child: multiColorSentence(
                  text: ["ALREADY HAVE AN ACCOUNT? ", "LOG IN"],
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
