import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginServices {
  static Future<Map<String, dynamic>?> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData(
          fields: "name,email,picture.width(200)",
        );

        print('Facebook Login Success');
        print('Name: ${userData['name']}');
        print('Email: ${userData['email']}');
        print('Picture: ${userData['picture']['data']['url']}');

        return userData;
      } else if (result.status == LoginStatus.cancelled) {
        print('Facebook Login Cancelled');
        return null;
      } else {
        print(' Facebook Login Failed: ${result.message}');
        return null;
      }
    } catch (e) {
      print('Facebook Login Error: $e');
      return null;
    }
  }

  static Future<void> logoutFromFacebook() async {
    await FacebookAuth.instance.logOut();
    print(' Facebook Logout Success');
  }

  static Future<bool> isLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    return accessToken != null;
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        final userData = await FacebookAuth.instance.getUserData(
          fields: "name,email,picture.width(200)",
        );
        return userData;
      }
      return null;
    } catch (e) {
      print(' Get User Data Error: $e');
      return null;
    }
  }
}
