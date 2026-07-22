import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_walking_2/repositories/user_repository.dart';
import 'package:social_walking_2/ui/sw_color.dart';
import 'package:social_walking_2/ui/user_profile_image.dart';

class CowalksScreen extends ConsumerStatefulWidget {
  const CowalksScreen({super.key});

  @override
  ConsumerState<CowalksScreen> createState() => _CowalksScreenState();
}

class _CowalksScreenState extends ConsumerState<CowalksScreen> {
  Widget personCard() {
    return Container(
      decoration: BoxDecoration(
        color: SWColor.grayLight,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Row(
        children: [
          //UserProfileImage(imageURL: imageURL, radius: radius, showStatusDot: showStatusDot)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Co-Walks"), backgroundColor: SWColor.white),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8.0,
          children: [
            StreamBuilder(
              stream: ref.watch(userRepositoryProvider).getUsers(),
              builder: (context, snapshot) {
                return Text("hi");
              },
            ),
          ],
        ),
      ),
    );
  }
}
