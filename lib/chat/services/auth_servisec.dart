import 'package:avrod/chat/helper/helper_function.dart';
import 'package:avrod/chat/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login functinon
  Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        return true;
      }
    } on FirebaseException catch (e) {
      // print(e);
      return e.message;
    }
  }

  // register

  Future registeUserWithEmailandPassword(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        await DtabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseException catch (e) {
      // print(e);
      return e.message;
    }
  }

  // Sign out

  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailSf('');
      await HelperFunction.saveUserNameSf('');
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
