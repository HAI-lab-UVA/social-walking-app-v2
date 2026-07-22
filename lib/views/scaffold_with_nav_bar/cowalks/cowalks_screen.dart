import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:social_walking_2/models/classes/sw_user.dart';
import 'package:social_walking_2/repositories/user_repository.dart';
import 'package:social_walking_2/ui/sw_color.dart';
import 'package:social_walking_2/ui/user_profile_image.dart';

class CowalksScreen extends ConsumerStatefulWidget {
  const CowalksScreen({super.key});

  @override
  ConsumerState<CowalksScreen> createState() => _CowalksScreenState();
}

class _CowalksScreenState extends ConsumerState<CowalksScreen> {
  final usersStreamProvider = StreamProvider<List<SWUser>>((ref) {
    return ref.watch(userRepositoryProvider).getUsersExcludingCurrent();
  });

  Widget personCard(SWUser user) {
    return Container(
      decoration: BoxDecoration(
        color: SWColor.grayLight,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            UserProfileImage(
              imageURL: user.profileImageURL,
              radius: 26.0,
              showStatusDot: true,
              statusDotColor: user.isCurrentlyAvailable()
                  ? SWColor.green
                  : SWColor.grayLight,
            ),
            SizedBox(width: 10.0),
            Text(
              "${user.firstName} ${user.lastName}",
              style: Theme.of(context).textTheme.bodyMedium!,
              textAlign: TextAlign.start,
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Symbols.person_book, weight: 600.0, size: 28.0),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Symbols.chat, weight: 600.0, size: 28.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(usersStreamProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Co-Walks"), backgroundColor: SWColor.white),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8.0,
          children: [
            usersAsync.when(
              data: (users) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: personCard(users[index]),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Text('Error loading users'),
            ),
          ],
        ),
      ),
    );
  }
}
