import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../CommonViews/ContinueWithView.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                'Login here',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Color(0XFF1F41BB),
                ),
              ),
            ),
            const Center(
              child: Text(
                "Welcome back you've been missed",
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
              child: makeSignInButton(),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Don't have account? ",
                    style: TextStyle(color: Color(0XFF494949), fontSize: 14)),
                TextSpan(
                  text: 'Sign up',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('Signup Tapped');
                    },
                )
              ])),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: ContinueWithView(),
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
      ],
    );
  }

  Widget makeSignInButton() {
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
          'Sign in',
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
}
