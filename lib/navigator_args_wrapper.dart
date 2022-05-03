import 'bookmodel.dart';
import 'package:hello_books/themes.dart';

class NavigatorArgsWrapper {
  final BookModel book;
  final WrappedTheme theme;
  NavigatorArgsWrapper(this.book, this.theme);
}