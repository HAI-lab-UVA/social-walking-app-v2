import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/models/classes/sw_user.dart';
import 'package:social_walking_2/models/enums/sw_gender.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/repositories/user_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';

class OnboadingScreen extends ConsumerStatefulWidget {
  const OnboadingScreen({super.key});

  @override
  ConsumerState<OnboadingScreen> createState() => _OnboadingScreenState();
}

class _OnboadingScreenState extends ConsumerState<OnboadingScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  late String pronouns;
  late SWGender gender;

  final formKey = GlobalKey<FormState>();
  bool isProcessingOnboarding = false;

  void createAccount() async {
    if (!isProcessingOnboarding) {
      setState(() {
        isProcessingOnboarding = true;
      });
      if (formKey.currentState!.validate()) {
        final uid = ref.read(authRepositoryProvider).getCurrentUserId();
        final newUser = SWUser(
          created: DateTime.now(),
          id: uid,
          fcmToken: "placeholder",
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          dateOfBirth: DateTime.now(),
          gender: gender,
          biography: "placeholder",
          profileImageURL: null,
        );
        ref.read(userRepositoryProvider).createUser(uid, newUser).then((_) {
          if (mounted) {
            context.go("/home");
          }
        });
      } else {
        setState(() {
          isProcessingOnboarding = false;
        });
      }
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listViewItems = [
      SizedBox(height: 30),
      Text(
        "Hello! Welcome to the Social Walking Community",
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(color: SWColor.white),
        textAlign: TextAlign.center,
      ),
      Text(
        "First, tell us about yourself",
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(color: SWColor.white),
        textAlign: TextAlign.center,
      ),
      Text(
        "(You can change this information later)",
        style: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(color: SWColor.white),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 30),
      Form(
        key: formKey,
        child: IntrinsicWidth(
          child: Column(
            spacing: 8.0,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textInputField(
                hintText: "FIRST NAME",
                controller: firstNameController,
                context: context,
                validator: (value) {
                  if (value == null || value.replaceAll(" ", "") == "") {
                    return "First name cannot be blank.";
                  }
                  return null;
                },
              ),
              textInputField(
                hintText: "LAST NAME",
                controller: lastNameController,
                context: context,
                validator: (value) {
                  if (value == null || value.replaceAll(" ", "") == "") {
                    return "Last name cannot be blank.";
                  }
                  return null;
                },
              ),
              dropdownMenu(
                hintText: "GENDER",
                data: SWGender.values.map((e) => e.formattedName).toList(),
                context: context,
                onChanged: (v) {
                  setState(() {
                    if (v != null) {
                      gender = SWGender.values.byName(v);
                    }
                  });
                },
                validator: (value) {
                  if (value == null || value == "") {
                    return "Gender cannot be blank.";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      customButton(
        text: "LET'S GO!",
        onPressed: createAccount,
        backgroundColor: SWColor.blue,
      ),

      SizedBox(height: 30),
    ];
    return Scaffold(
      backgroundColor: SWColor.blueLight,
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: listViewItems.length,
          itemBuilder: (context, index) => listViewItems[index],
          separatorBuilder: (context, index) => const SizedBox(height: 8.0),
        ),
      ),
    );
  }
}
