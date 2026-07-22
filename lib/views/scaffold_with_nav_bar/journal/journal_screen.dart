import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Text("Journal");
  }
}
