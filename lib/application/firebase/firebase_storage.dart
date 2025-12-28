import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final _storage = FirebaseStorage.instance;
  static final _auth = FirebaseAuth.instance;

  /// Upload image and return download URL
  static Future<String?> uploadUserImage(File imageFile) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return null;
      }

      final ref = _storage
          .ref()
          .child("userimage")
          .child(user.uid)
          .child("profile.jpg");

      final metadata = SettableMetadata(contentType: "image/jpeg");

      final uploadTask = await ref.putFile(imageFile, metadata);

      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  /// Delete user image
  static Future<void> deleteUserImage() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final ref = _storage
        .ref()
        .child("userimage")
        .child(user.uid)
        .child("profile.jpg");

    try {
      await ref.delete();
    } catch (e) {
      // Ignore if file doesn't exist
      print("Delete failed: $e");
    }
  }
}
