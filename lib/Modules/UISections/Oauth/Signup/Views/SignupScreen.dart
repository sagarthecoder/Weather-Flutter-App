import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/Modules/Service/AuthService/AuthService.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/CommonViews/ContinueWithView.dart';
import 'package:weather_flutter/main.dart';

import '../../Login/Model/OauthEnums.dart';
import '../../Login/ViewModel/AuthViewModel.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthViewModel viewModel = AuthViewModel();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.addListener(updateStates);
    password.addListener(updateStates);
    confirmPassword.addListener(updateStates);
  }

  void updateStates() {
    setState(() {});
  }

  void updateLoadingState(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        toolbarHeight: 30,
      ),
      body: Stack(
        children: [
          Container(
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
                child: ContinueWithView(
                  selectedSocialProviderHandler: (provider) {
                    socialLogin(provider, context);
                  },
                ),
              )
            ]),
          ),
          showLoaderIfNeeded()
        ],
      ),
    );
  }

  Widget buildTextFields() {
    return Column(
      children: [
        makeTextField('Email', email),
        const SizedBox(
          height: 26,
        ),
        makeTextField('Password', password),
        const SizedBox(
          height: 26,
        ),
        makeTextField('Confirm Password', confirmPassword)
      ],
    );
  }

  Widget makeTextField(String hintText, TextEditingController? controller) {
    return TextField(
      controller: controller,
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

  Widget makeSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Opacity(
        opacity: isEnabledSignUpButton() ? 1.0 : 0.4,
        child: ElevatedButton(
          onPressed: isEnabledSignUpButton()
              ? () {
                  print("Sign up button pressed");
                  signup(context);
                }
              : null,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color((0XFF1F41BB)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: const Text(
            'Sign Up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  bool isEnabledSignUpButton() {
    return (!email.text.isEmpty &&
        !password.text.isEmpty &&
        !confirmPassword.text.isEmpty &&
        password.text == confirmPassword.text);
  }

  Widget showLoaderIfNeeded() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container();
    }
  }

  showAlertDialog(BuildContext context, String message,
      [String title = 'Alert!']) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> socialLogin(
      SocialSignInProvider provider, BuildContext context) async {
    updateLoadingState(true);
    try {
      await viewModel.socialSignin(provider);
      updateLoadingState(false);
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return DemoHome();
      }));
    } catch (err) {
      updateLoadingState(false);
      print('Error = ${err.toString()}');
      showAlertDialog(context, err.toString());
    }
  }

  Future<void> signup(BuildContext context) async {
    updateLoadingState(true);
    try {
      await AuthService.shared.signupWithEmail(email.text, password.text);
      updateLoadingState(false);
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return DemoHome();
      }));
    } catch (err) {
      print("Error = ${err.toString()}");
      updateLoadingState(false);
      showAlertDialog(context, err.toString());
    }
  }
}
