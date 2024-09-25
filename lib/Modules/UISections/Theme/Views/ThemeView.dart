import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/ThemeProvider.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  State<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.currentTheme == ThemeEnum.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Theme',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black87 : Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode ? Colors.black45 : Colors.grey[400]!,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                  size: 100,
                  color: isDarkMode ? Colors.yellow : Colors.orange,
                ),
                SizedBox(height: 20),
                Text(
                  isDarkMode ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Switch(
                  value: isDarkMode,
                  onChanged: (_) {
                    if (isDarkMode) {
                      themeProvider.changeTheme(ThemeEnum.light);
                    } else {
                      themeProvider.changeTheme(ThemeEnum.dark);
                    }
                  },
                  activeColor: Colors.orangeAccent,
                  inactiveThumbColor: Colors.blue,
                  inactiveTrackColor: Colors.blue[100],
                ),
                SizedBox(height: 10),
                Text(
                  'Toggle the switch to change the theme',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
