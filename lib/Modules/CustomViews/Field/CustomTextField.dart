import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../UISections/Theme/Model/ThemeProvider.dart';

class CustomTextField extends StatefulWidget {
  final String? placeholder;
  final TextEditingController controller;
  const CustomTextField(
      {this.placeholder = "", required this.controller, super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintStyle:
            themeProvider.currentThemeData?.textTheme?.labelSmall?.copyWith(
          color: themeProvider.currentThemeData?.textTheme.labelSmall?.color
              ?.withOpacity(0.4),
        ),
        hintText: widget.placeholder,
        filled: true,
        fillColor: Colors.white60,
      ),
    );
  }
}
