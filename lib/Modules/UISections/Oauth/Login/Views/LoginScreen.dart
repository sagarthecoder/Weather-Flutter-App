import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/Modules/CustomViews/Field/CustomTextField.dart';
import 'package:weather_flutter/Modules/Service/AuthService/AuthService.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/Model/OauthEnums.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/ViewModel/AuthViewModel.dart';

import '../../../Home/Views/HomeScreen.dart';
import '../../../Theme/Model/ThemeProvider.dart';
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
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        backgroundColor:
            themeProvider.currentThemeData?.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor:
              themeProvider.currentThemeData?.appBarTheme.backgroundColor,
          toolbarHeight: 30,
        ),
        body: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 31, right: 31),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login here',
                  style:
                      themeProvider.currentThemeData?.textTheme.headlineLarge,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: buildTextFields(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      style:
                          themeProvider.currentThemeData?.textButtonTheme.style,
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password?',
                        ),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 26),
                width: double.infinity,
                child: makeSignInButton(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Don't have account? ",
                      style: TextStyle(color: Colors.black54, fontSize: 14)),
                  TextSpan(
                    text: 'Sign up',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const SignupScreen();
                        }));
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
          showLoaderIfNeeded(),
        ]));
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

  Widget buildTextFields() {
    return Column(
      children: [
        CustomTextField(
          placeholder: 'Email',
          controller: email,
        ),
        const SizedBox(
          height: 26,
        ),
        CustomTextField(
          placeholder: 'Password',
          controller: password,
        ),
      ],
    );
  }

  Widget makeSignInButton() {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: double.infinity,
      height: 54,
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
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Text(
            'Sign in',
            style: themeProvider.currentThemeData?.textTheme.titleSmall,
          ),
        ),
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
      gotoHome(context);
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
      gotoHome(context);
    } catch (err) {
      updateLoadingState(false);
      print('Error = ${err.toString()}');
      showAlertDialog(context, err.toString());
    }
  }

  void gotoHome(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
