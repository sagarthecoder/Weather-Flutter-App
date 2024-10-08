import 'package:flutter/material.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/Model/OauthEnums.dart';

class ContinueWithView extends StatefulWidget {
  final void Function(SocialSignInProvider provider)?
      selectedSocialProviderHandler;
  // const ContinueWithView({Key? key, })
  const ContinueWithView({super.key, this.selectedSocialProviderHandler});

  @override
  State<ContinueWithView> createState() => _ContinueWithViewState();
}

class _ContinueWithViewState extends State<ContinueWithView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Or continue with',
            style: TextStyle(
                color: Colors.brown, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              makeSocialButton(SocialSignInProvider.google),
              const SizedBox(
                width: 10,
              ),
              makeSocialButton(SocialSignInProvider.facebook),
              const SizedBox(
                width: 10,
              ),
              makeSocialButton(SocialSignInProvider.apple),
            ],
          )
        ],
      ),
    );
  }

  Widget makeSocialButton(SocialSignInProvider provider) {
    return ElevatedButton(
      onPressed: () {
        widget.selectedSocialProviderHandler?.call(provider);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Image.asset(
        height: 50,
        provider.getSocialImagePath(),
      ),
    );
  }
}
