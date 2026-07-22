import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CowalksScreen extends ConsumerStatefulWidget {
  const CowalksScreen({super.key});

  @override
  ConsumerState<CowalksScreen> createState() => _CowalksScreenState();
}

class _CowalksScreenState extends ConsumerState<CowalksScreen> {
  @override
  Widget build(BuildContext context) {
    return Text("Cowalks");
  }
}
