import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleLoginServices {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '793538857243-5ngj228flbb6nj68627suim4qj48ra2a.apps.googleusercontent.com',
  );

  static Future<String?> login() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return null; // User cancelled login
      }

      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return await userCredential.user?.getIdToken();
    } catch (error) {
      print("Google login error: $error");
      return null;
    }
  }

  static Future<void> logout() async {
    // Sign out from both Google and Firebase.
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
