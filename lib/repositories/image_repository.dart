import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ImageRepository {
  final FirebaseStorage storage;
  const ImageRepository({required this.storage});

  Future<String> uploadImage(Uint8List imageData, {String? mime}) async {
    final uid = const Uuid().v1();
    final metadata = SettableMetadata(contentType: mime);
    final ref = storage.ref().child('images/$uid');
    final task = ref.putData(imageData, metadata);
    final snapshot = await task;
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }
}

final Provider<ImageRepository> imageRepositoryProvider =
    Provider<ImageRepository>((ref) {
      return ImageRepository(storage: FirebaseStorage.instance);
    });
