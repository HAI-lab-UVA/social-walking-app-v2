import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_walking_2/models/classes/sw_user.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';

class UserRepository {
  final FirebaseFirestore db;
  final AuthRepository authRepository;

  const UserRepository({required this.db, required this.authRepository});

  Stream<SWUser> getUser(String uid) {
    final docRef = db.collection("sw2_users").doc(uid);
    return docRef.snapshots().map((doc) {
      if (doc.exists) {
        return SWUser.fromJson(doc.data()!);
      } else {
        throw Exception("User with id $uid does not exist");
      }
    });
  }

  Stream<List<SWUser>> getUsers() {
    return db
        .collection("sw2_users")
        .snapshots()
        .map(
          (query) =>
              query.docs.map((doc) => SWUser.fromJson(doc.data())).toList(),
        );
  }

  Stream<SWUser> getCurrentUser() {
    final uid = authRepository.getCurrentUserId();
    final docRef = db.collection("sw2_users").doc(uid);
    return docRef.snapshots().map((doc) {
      if (doc.exists) {
        return SWUser.fromJson(doc.data()!);
      } else {
        throw Exception("User with id $uid does not exist");
      }
    });
  }

  Future<bool> userExists(String uid) async {
    final doc = await db.collection("sw2_users").doc(uid).get();
    return doc.exists;
  }

  Future<bool> currentUserExists() async {
    final uid = authRepository.getCurrentUserId();
    final doc = await db.collection("sw2_users").doc(uid).get();
    return doc.exists;
  }

  Future<void> createUser(String uid, SWUser user) async {
    await db.collection("sw2_users").doc(uid).set(user.toJson());
  }

  Future<void> updateUserInfo({
    required String uid,
    required String key,
    required dynamic value,
    dynamic Function(dynamic existingValue, dynamic newValue)?
    updateExistingValue,
  }) async {
    if (updateExistingValue != null) {
      final docSnapshot = await db.collection('users').doc(uid).get();
      final existingValue = docSnapshot.data()![key];
      final updatedValue = updateExistingValue(existingValue, value);
      await db.collection('sw2_users').doc(uid).update({key: updatedValue});
    } else {
      await db.collection('sw2_users').doc(uid).update({key: value});
    }
  }

  Future<void> finishUserSetup({required String uid}) async {
    await updateUserInfo(uid: uid, key: "finishedSetup", value: true);
  }
}

final Provider<UserRepository> userRepositoryProvider =
    Provider<UserRepository>((ref) {
      return UserRepository(
        db: FirebaseFirestore.instance,
        authRepository: ref.watch(authRepositoryProvider),
      );
    });
