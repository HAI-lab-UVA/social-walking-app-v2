import 'package:flutter/material.dart';
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
              Image(image: AssetImage("images/welcome.png")),
              Text(
                "Welcome to Social Walking",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              multicolorSentence(
                text: ["Meet ", "new people ", "and your ", "fitness goals"],
                colors: [
                  null,
                  SWColor.lightblue.color,
                  null,
                  SWColor.green.color,
                ],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              indigoButton(text: "GET STARTED TODAY", onPressed: () {}),
              multicolorSentence(
                text: ["ALREADY HAVE AN ACCOUNT? ", "LOG IN"],
                colors: [null, SWColor.blue.color],
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
