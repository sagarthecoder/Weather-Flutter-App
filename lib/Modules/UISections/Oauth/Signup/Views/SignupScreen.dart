import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/Modules/CustomViews/Field/CustomTextField.dart';
import 'package:weather_flutter/Modules/Service/AuthService/AuthService.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/CommonViews/ContinueWithView.dart';

import '../../../Home/Views/HomeScreen.dart';
import '../../../Weather/Views/WeatherScreen.dart';
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
            margin: const EdgeInsets.only(top: 20, left: 31, right: 31),
            child: Column(children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create an Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: buildTextFields(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                width: double.infinity,
                child: makeSignUpButton(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.black54, fontSize: 14)),
                  TextSpan(
                    text: 'Login',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Login Tapped');
                        Navigator.pop(context);
                      },
                  )
                ])),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
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
        CustomTextField(placeholder: 'Email', controller: email),
        const SizedBox(
          height: 26,
        ),
        CustomTextField(placeholder: 'Password', controller: password),
        const SizedBox(
          height: 26,
        ),
        CustomTextField(
            placeholder: 'Confirm password', controller: confirmPassword),
      ],
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
              backgroundColor: Colors.blueAccent,
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
    return (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty &&
        password.text == confirmPassword.text);
  }

  Widget showLoaderIfNeeded() {
    if (isLoading) {
      return const Center(
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
      child: const Text("OK"),
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
      gotoHome(context);
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
      gotoHome(context);
    } catch (err) {
      print("Error = ${err.toString()}");
      updateLoadingState(false);
      showAlertDialog(context, err.toString());
    }
  }

  void gotoHome(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
