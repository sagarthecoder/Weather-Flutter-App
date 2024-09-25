import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/Views/LoginScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:weather_flutter/Modules/UISections/Theme/Model/ThemeProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ThemeProvider.instance.changeTheme(ThemeEnum.light);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
