import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContinueWithView extends StatefulWidget {
  const ContinueWithView({super.key});

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
                color: Color(0XFF1F41BB),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              makeSocialButton('utils/images/google-icon.png'),
              SizedBox(
                width: 10,
              ),
              makeSocialButton('utils/images/facebook-icon.png'),
              SizedBox(
                width: 10,
              ),
              makeSocialButton('utils/images/apple-icon.png'),
            ],
          )
        ],
      ),
    );
  }

  Widget makeSocialButton(String imageName) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0XFFECECEC),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Image.asset(
        imageName,
      ),
    );
  }
}
