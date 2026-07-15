import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              Flexible(
                flex: 5,
                child: Image(image: AssetImage("images/welcome.png")),
              ),
              Text(
                "Welcome to Social Walking",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              multiColorSentence(
                text: ["Meet ", "new people ", "and your ", "fitness goals"],
                colors: [null, SWColor.blueLight, null, SWColor.green],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              customButton(
                text: "GET STARTED TODAY",
                onPressed: () => context.go("/signup"),
              ),
              GestureDetector(
                onTap: () => context.go("/login"),
                child: multiColorSentence(
                  text: ["ALREADY HAVE AN ACCOUNT? ", "LOG IN"],
                  colors: [null, SWColor.blueLight],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Spacer(),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
