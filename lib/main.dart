import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/Views/LoginScreen.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: decideDestination(),
    );
  }

  Widget decideDestination() {
    return const LoginScreen();
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const DemoHome();
        } else {
          return const LoginScreen();
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
    checkAPI();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 40,
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }

  Future<void> checkAPI() async {
    // try {
    //   var result = await NetworkService.shared.genericApiRequest<WeatherResult>(
    //       "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=5d6689818613ac9263790406144a1fb8",
    //       RequestMethod.get,
    //       WeatherResult.fromJson);
    //   print("Result = ${result?.sys?.sunset}");
    // } catch (err) {
    //   print('err = ${err}');
    // }
  }
}
