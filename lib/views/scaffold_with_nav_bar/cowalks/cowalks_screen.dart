import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_walking_2/ui/sw_color.dart';

class CowalksScreen extends ConsumerStatefulWidget {
  const CowalksScreen({super.key});

  @override
  ConsumerState<CowalksScreen> createState() => _CowalksScreenState();
}

class _CowalksScreenState extends ConsumerState<CowalksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Co-Walks"), backgroundColor: SWColor.white),
      body: Padding(padding: const EdgeInsets.all(8.0), child: Text("hi")),
    );
  }
}
