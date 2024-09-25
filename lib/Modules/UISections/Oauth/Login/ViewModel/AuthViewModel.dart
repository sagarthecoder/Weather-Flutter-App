import 'package:weather_flutter/Modules/Service/AuthService/AuthService.dart';

import '../Model/OauthEnums.dart';

class AuthViewModel {
  Future<void> socialSignin(SocialSignInProvider provider) async {
    switch (provider) {
      case SocialSignInProvider.google:
        await AuthService.shared.signInWithGoogle();
      default:
        break;
    }
  }
}
