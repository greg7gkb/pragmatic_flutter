import 'package:flutter/material.dart';

get defaultTheme => _pinkTheme;

WrappedTheme next(WrappedTheme curr) {
  if (curr == _pinkTheme) return _darkTheme;
  if (curr == _darkTheme) return _blueTheme;
  if (curr == _blueTheme) return _pinkTheme;
  return _pinkTheme; // Default
}

WrappedTheme getById(final int id) {
  if (_pinkTheme.id == id) return _pinkTheme;
  if (_darkTheme.id == id) return _darkTheme;
  if (_blueTheme.id == id) return _blueTheme;
  throw Exception('Can\'t find theme id of: $id');
}

class WrappedTheme {
  final ThemeData theme;
  final int id;
  WrappedTheme(this.theme, this.id);

  @override
  bool operator ==(Object other) => other is WrappedTheme && id == other.id;

  @override
  int get hashCode => theme.hashCode;

  @override
  String toString() {
    return 'WrappedTheme{id: $id}';
  }
}

get _pinkTheme => WrappedTheme(
    ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.pink,
      secondaryHeaderColor: Colors.pinkAccent,
    ),
    1);

get _darkTheme => WrappedTheme(
    ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.orange,
      secondaryHeaderColor: Colors.orangeAccent,
    ),
    2);

get _blueTheme => WrappedTheme(
    ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      secondaryHeaderColor: Colors.blueAccent,
    ),
    3);
