import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/Views/LoginScreen.dart';
import 'package:weather_flutter/firebase_options.dart';
import 'Modules/UISections/Oauth/Signup/Views/SignupScreen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: decideDestination(),
    );
  }

  Widget decideDestination() {
    return LoginScreen();
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DemoHome();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

class DemoHome extends StatefulWidget {
  const DemoHome({super.key});

  @override
  State<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 40,
      ),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
