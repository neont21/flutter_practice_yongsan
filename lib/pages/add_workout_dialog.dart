//filename:add_workout_dialog.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker_2026/logics/my_workout_provider.dart';

import '../models/my_workout.dart';
import '../services/firebase_storage_service.dart';
import '../widgets/show_snackbar.dart';

class AddWorkoutDialog extends StatefulWidget {
  const AddWorkoutDialog({super.key});

  @override
  State<AddWorkoutDialog> createState() => _AddWorkoutDialogState();
}

class _AddWorkoutDialogState extends State<AddWorkoutDialog> {
  String? newWorkoutTitle;
  int? newWorkoutMinutes;
  String? newWorkoutImageUrl;

  final FirebaseStorageService _storage = FirebaseStorageService();
  final ImagePicker _picker = ImagePicker();

  ImageProvider? _previewImage;
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    try {
      _pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (_pickedImage != null) {
        setState(() {
          _previewImage = FileImage(File(_pickedImage!.path));
        });
      }
    } catch (e) {
      showSnackBar('$e');
    }
  }

  Future<String?> uploadWorkout(XFile? pickedFile) async {
    if (pickedFile == null) {
      return null;
    }

    return await _storage
        .uploadWorkoutImage(
          bytes: await pickedFile.readAsBytes(),
          path: pickedFile.path,
          pickedFileHash: pickedFile.hashCode,
        )
        .catchError((error) {
          showSnackBar('$error');
        });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorScheme.onPrimary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 18,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Text(
                '나만의 운동 추가하기',
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.shadow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                newWorkoutTitle = value;
              },
              decoration: InputDecoration(
                labelText: '운동명',
                labelStyle: Theme.of(context).textTheme.headlineSmall,
                border: UnderlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              autofocus: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이미지',
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.shadow,
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: _previewImage != null
                      ? DecorationImage(
                          image: _previewImage!,
                          fit: BoxFit.cover,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '이미지 변경',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                newWorkoutMinutes = int.parse(value);
              },
              decoration: InputDecoration(
                labelText: '운동 시간',
                labelStyle: textTheme.headlineSmall,
                border: UnderlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              color: colorScheme.primary,
            ),
            height: 50,
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                newWorkoutImageUrl = await uploadWorkout(_pickedImage);
                Provider.of<MyWorkoutProvider>(
                  context,
                  listen: false,
                ).addMyWorkout(
                  MyWorkout(
                    name: newWorkoutTitle!,
                    imageURL: newWorkoutImageUrl!,
                    minutes: newWorkoutMinutes!,
                  ),
                );
                context.pop();
              },
              child: Text(
                '운동 추가',
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
