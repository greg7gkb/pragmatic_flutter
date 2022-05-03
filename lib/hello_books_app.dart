import 'book_details_page.dart';
import 'books_home.dart';
import 'dart:developer' as dev;
import 'navigator_args_wrapper.dart';
import 'package:flutter/material.dart';
import 'page_not_found.dart';
import 'themes.dart';

class HelloBooksApp extends StatelessWidget {
  const HelloBooksApp({Key? key}) : super(key: key);
  static const String title = 'Hello Books!';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: title,
      theme: defaultTheme.theme,
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    dev.log('Trying to route to: ${routeSettings.name}');
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const BooksHome(title: title + ' Home Page')
        );

      case '/details':
        if (args is NavigatorArgsWrapper) {
          return MaterialPageRoute(
            builder: (context) => BookDetailsPage(
              book: args.book,
              theme: args.theme,
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) => const PageNotFound(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const PageNotFound(),
        );
    }
  }
}
