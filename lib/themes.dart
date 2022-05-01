import 'package:flutter/material.dart';

get defaultTheme => _pinkTheme;

ThemeData next(ThemeData curr) {
  if (curr == _pinkTheme) return _darkTheme;
  if (curr == _darkTheme) return _pinkTheme;
  return _pinkTheme; // Default
}

get _pinkTheme => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.pink,
      secondaryHeaderColor: Colors.pinkAccent,
    );

get _darkTheme => ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.orange,
      secondaryHeaderColor: Colors.orangeAccent,
    );
