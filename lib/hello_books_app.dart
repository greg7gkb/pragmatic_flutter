import 'package:flutter/material.dart';

import 'my_home_page.dart';

class HelloBooksApp extends StatelessWidget {
  const HelloBooksApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String title = 'Hello Books!';
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: title + ' Home Page'),
    );
  }
}
