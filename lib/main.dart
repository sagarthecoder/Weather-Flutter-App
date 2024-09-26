import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/Modules/UISections/Home/Views/HomeScreen.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/Views/LoginScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:weather_flutter/Modules/UISections/Theme/Model/ThemeProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ThemeProvider.instance.changeTheme(ThemeEnum.light);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider.instance),
      ],
      builder: (context, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context).currentThemeData,
          home: decideDestination(),
        );
      },
    );
  }

  Widget decideDestination() {
    return const LoginScreen();
  }
}
