import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageService {
  final storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadProfileImage({
    required Uint8List bytes,
    required String path,
    String? uid,
  }) async {
    if (uid == null) {
      throw Exception('잘못된 접근입니다.');
    }
    try {
      final profileRef = storageRef.child('user_profile/${uid}_profile_image.png');
      final metadata = SettableMetadata(
        contentType: 'image/png',
        customMetadata: {
          'picked-file-path': path,
        },
      );
      await profileRef.putData(bytes, metadata);
      final downloadUrl = await profileRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('upload 실패: $e');
    }
  }

  Future<String> uploadWorkoutImage({
    required Uint8List bytes,
    required String path,
    required int pickedFileHash,
  }) async {
    try {
      final workoutRef = storageRef.child('my_workout/${pickedFileHash}_workout_image.png');
      final metadata = SettableMetadata(
        contentType: 'image/png',
        customMetadata: {
          'picked-file-path': path,
        },
      );
      await workoutRef.putData(bytes, metadata);
      final downloadUrl = await workoutRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('upload 실패: $e');
    }
  }

  Future<void> deleteProfileImage(String? uid) async {
    if (uid == null) {
      throw Exception('잘못된 접근입니다.');
    }
    final profileRef = storageRef.child('user_profile/${uid}_profile_image.png');
    try {
      profileRef.delete();
    } catch (e) {
      throw Exception('delete 실패: $e');
    }
  }
}
