import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/Config/WeatherConfig.dart';
import 'package:weather_flutter/Modules/Service/AuthService/AuthService.dart';
import 'package:weather_flutter/Modules/Service/LocationService/LocationService.dart';
import 'package:weather_flutter/Modules/Service/NetworkService/NetworkService.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/Model/OauthEnums.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/ViewModel/AuthViewModel.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherResult.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/WeatherScreen.dart';
import 'package:weather_flutter/main.dart';

import '../../CommonViews/ContinueWithView.dart';
import '../../Signup/Views/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthViewModel viewModel = AuthViewModel();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.addListener(updateStates);
    password.addListener(updateStates);
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
        body: Stack(children: [
          Container(
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
                margin: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password?',
                          style:
                              TextStyle(color: Color(0XFF1F41BB), fontSize: 14),
                        ),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 26),
                width: double.infinity,
                child: makeSignInButton(),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Don't have account? ",
                      style: TextStyle(color: Color(0XFF494949), fontSize: 14)),
                  TextSpan(
                    text: 'Sign up',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SignupScreen();
                        }));
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
          showLoaderIfNeeded(),
        ]));
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

  Widget buildTextFields() {
    return Column(
      children: [
        makeTextField('Email', email),
        const SizedBox(
          height: 26,
        ),
        makeTextField('Password', password),
      ],
    );
  }

  Widget makeSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Opacity(
        opacity: isEnabledLoginButton() ? 1.0 : 0.4,
        child: ElevatedButton(
          onPressed: isEnabledLoginButton()
              ? () {
                  print("Sign in button pressed");
                  signIn(context);
                }
              : null,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color((0XFF1F41BB)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: const Text(
            'Sign in',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  Widget makeTextField(String hintText, TextEditingController controller) {
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

  bool isEnabledLoginButton() {
    return (email.text.isNotEmpty && password.text.isNotEmpty);
  }

  Future<void> socialLogin(
      SocialSignInProvider provider, BuildContext context) async {
    updateLoadingState(true);
    try {
      await viewModel.socialSignin(provider);
      updateLoadingState(false);
      gotoWeatherScreen(context);
    } catch (err) {
      updateLoadingState(false);
      print('Error = ${err.toString()}');
      showAlertDialog(context, err.toString());
    }
  }

  Future<void> signIn(BuildContext context) async {
    updateLoadingState(true);
    try {
      await AuthService.shared.signInWithEmail(email.text, password.text);
      updateLoadingState(false);
      gotoWeatherScreen(context);
    } catch (err) {
      updateLoadingState(false);
      print('Error = ${err.toString()}');
      showAlertDialog(context, err.toString());
    }
  }

  void gotoWeatherScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WeatherScreen()));
  }
}
