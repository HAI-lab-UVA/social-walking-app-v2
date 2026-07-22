import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';

class EditAvailabilityScreen extends ConsumerStatefulWidget {
  const EditAvailabilityScreen({super.key});

  @override
  ConsumerState<EditAvailabilityScreen> createState() =>
      _EditAvailabilityScreenState();
}

class _EditAvailabilityScreenState
    extends ConsumerState<EditAvailabilityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weekly Availability",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: SWColor.black),
        ),
        backgroundColor: SWColor.white,
      ),
      body: Padding(padding: const EdgeInsets.all(8.0), child: Text("hi")),
    );
  }
}
