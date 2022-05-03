import 'bookmodel.dart';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:hello_books/themes.dart';

class BookDetailsPage extends StatelessWidget {
  final BookModel book;
  final WrappedTheme theme;

  const BookDetailsPage({required this.book, required this.theme, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: theme.theme,
        child: Scaffold(
            appBar: AppBar(
              title: Text(book.volumeInfo.title),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Text(book.volumeInfo.description == null
                  ? "No description available"
                  : book.volumeInfo.description as String),
            )));
  }
}
