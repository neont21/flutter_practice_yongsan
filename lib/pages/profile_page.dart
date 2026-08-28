import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/firebase_storage_service.dart';
import '../services/firebase_auth_service.dart';
import '../widgets/show_snackbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? profileImageURL;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseStorageService _storage = FirebaseStorageService();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      String? downloadUrl;
      try {
        downloadUrl = await _storage.uploadProfileImage(
          bytes: await pickedFile.readAsBytes(),
          path: pickedFile.path,
          uid: _auth.user?.uid,
        );
        _auth.updatePhoto(downloadUrl);
        setState(() {
          profileImageURL = downloadUrl;
        });
      } catch (e) {
        showSnackBar('$e');
      }
    }
  }

  void _deleteImage() {
    _auth.deletePhoto().catchError((error) {
      showSnackBar('$error');
    });
    _storage
        .deleteProfileImage(_auth.user?.uid)
        .catchError((error) {
      showSnackBar('$error');
    });
    setState(() {
      profileImageURL = null;
    });
  }

  @override
  void initState() {
    super.initState();

    name = _auth.user?.displayName;
    email = _auth.user?.email;
    profileImageURL = _auth.user?.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text('프로필 설정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary, // 원하는 border 색상
                          width: 1.0,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: profileImageURL != null
                              ? NetworkImage(profileImageURL!)
                              : const AssetImage('assets/home/me.png'),
                          onBackgroundImageError: (_, __) {
                            setState(() {
                              profileImageURL = null;
                            });
                          },
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.camera_alt,
                            size: textTheme.headlineMedium?.fontSize,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceDim,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.close,
                              color: colorScheme.onPrimary,
                            ),
                            onPressed: _deleteImage,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: textTheme.titleLarge,
                  hintText: 'Enter your name',
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력하세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: email,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: textTheme.titleLarge,
                  border: UnderlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have you verified your email yet?',
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.shadow,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Send Email',
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              // 수정 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '수정',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              // 로그아웃/회원탈퇴
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '로그아웃',
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ),
                  Text('|'),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '회원탈퇴',
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
