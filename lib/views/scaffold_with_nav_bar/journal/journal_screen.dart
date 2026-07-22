import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/models/classes/sw_user.dart';
import 'package:social_walking_2/repositories/user_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final currentUserStreamProvider = StreamProvider<SWUser>((ref) {
    return ref.watch(userRepositoryProvider).getCurrentUser();
  });
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserStreamProvider);
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
                      "Your Availability",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: SWColor.black),
                      textAlign: TextAlign.start,
                    ),
                    userAsync.when(
                      data: (user) {
                        final isAvailable = user.isCurrentlyAvailable();
                        return Text(
                          "You are currently ${isAvailable ? "Available" : "Unavailable"}",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: isAvailable
                                    ? SWColor.green
                                    : SWColor.red,
                              ),
                          textAlign: TextAlign.center,
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (error, stackTrace) => Text('Error loading user'),
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
