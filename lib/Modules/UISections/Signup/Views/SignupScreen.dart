import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black38,
          toolbarHeight: 30,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20, left: 31, right: 31),
          child: Column(children: [
            const Center(
              child: Text(
                'Create an Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Color(0XFF1F41BB),
                ),
              ),
            ),
            const Center(
              child: Text(
                'Create an account so you can explore\nweathers of all countries',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: buildTextFields(),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              width: double.infinity,
              child: makeSignUpButton(),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Color(0XFF494949), fontSize: 14)),
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('Login Tapped');
                    },
                )
              ])),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: buildContinueWithSection(),
            )
          ]),
        ));
  }

  Widget buildTextFields() {
    return Column(
      children: [
        makeTextField('Email'),
        const SizedBox(
          height: 26,
        ),
        makeTextField('Password'),
        const SizedBox(
          height: 26,
        ),
        makeTextField('Confirm Password')
      ],
    );
  }

  Widget makeSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Color((0XFF1F41BB)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: const Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Widget makeTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintStyle: TextStyle(color: Colors.grey[800]?.withOpacity(0.4)),
        hintText: hintText,
        filled: true,
        fillColor: Color(0XffF1F4FF),
      ),
    );
  }

  Widget buildContinueWithSection() {
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
