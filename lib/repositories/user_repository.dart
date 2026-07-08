import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';

class UserRepository {
  final FirebaseFirestore db;
  final AuthRepository authRepository;

  const UserRepository({required this.db, required this.authRepository});
}

final Provider<UserRepository> userRepositoryProvider =
    Provider<UserRepository>((ref) {
      return UserRepository(
        db: FirebaseFirestore.instance,
        authRepository: ref.watch(authRepositoryProvider),
      );
    });
