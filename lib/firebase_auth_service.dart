import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService() : _auth = FirebaseAuth.instance {
    _auth.setLanguageCode('kr');
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    String? errorMessage;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.currentUser?.updateDisplayName(name);
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (authError) {
      switch (authError.code) {
        case 'weak-password':
          errorMessage='패스워드가 취약합니다.';
        case 'email-already-in-use':
          errorMessage='이미 사용 중인 이메일입니다.';
        default:
          errorMessage=authError.message;
      }
    } catch(e) {
      errorMessage = '회원가입 에러: $e';
    }
    if (errorMessage != null) {
      throw Exception(errorMessage);
    }
  }

  Future<void> signInWithEmail() async {}

  Future<void> resetPassword() async {}

  Future<void> deleteAccount() async {}

  Future<void> signOut() async {}

  Future<void> updateProfile() async {}
}
