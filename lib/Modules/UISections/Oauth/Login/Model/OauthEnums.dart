enum SocialSignInProvider {
  google,
  facebook,
  apple;
}

extension SocialSignInProviderExtension on SocialSignInProvider {
  String getSocialImagePath() {
    switch (this) {
      case SocialSignInProvider.google:
        return 'utils/images/google-icon.png';
      case SocialSignInProvider.facebook:
        return 'utils/images/facebook-icon.png';
      case SocialSignInProvider.apple:
        return 'utils/images/apple-icon.png';
    }
  }
}
