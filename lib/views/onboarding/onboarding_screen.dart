import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  final formKey = GlobalKey<FormState>();

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final listViewItems = [
      Spacer(),
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
      Spacer(),
      Form(
        key: formKey,
        child: Column(
          spacing: 8.0,
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
          ],
        ),
      ),
      customButton(
        text: "LET'S GO!",
        onPressed: () {},
        backgroundColor: SWColor.blue,
      ),

      Spacer(),
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
