import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Journal"), backgroundColor: SWColor.white),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16.0,
          children: [
            Container(
              decoration: BoxDecoration(
                color: SWColor.grayLight,
                borderRadius: BorderRadius.circular(18.0),
              ),
              height: 300.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8.0,
                  children: [
                    Text(
                      "Scheduled Co-Walks",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: SWColor.black),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: SWColor.grayLight,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8.0,
                  children: [
                    Text(
                      "Your Availability Today",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: SWColor.black),
                      textAlign: TextAlign.start,
                    ),
                    customButton(
                      text: "EDIT WEEKLY AVAILABILITY",
                      onPressed: () {
                        context.goNamed("edit-availability");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
