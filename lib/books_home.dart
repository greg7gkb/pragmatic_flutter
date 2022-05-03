import 'bookmodel.dart';
import 'dart:developer' as dev;
import 'http.dart';
import 'navigator_args_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'themes.dart' as _themes;

const String keyOfThemeId = 'theme_id';

class BooksHome extends StatefulWidget {
  final String title;

  const BooksHome({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BooksHomeState();
}

class _BooksHomeState extends State<BooksHome> {
  _BooksHomeState() {
    dev.log('_BooksHomeState()');
  }

  _themes.WrappedTheme _theme = _themes.defaultTheme;
  late Future<bool> futureLoader;

  Future<bool> _restoreTheme() async {
    var prefs = await SharedPreferences.getInstance();
    var val = prefs.getInt(keyOfThemeId);
    if (val != null) {
      _theme = _themes.getById(val);
      dev.log('loaded theme of id: ${_theme.id}');
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    futureLoader = _restoreTheme();
    dev.log('initState(), theme: ${_theme.id}');
  }

  void _switchTheme() async {
    setState(() {
      _theme = _themes.next(_theme);
      dev.log('setState(), theme: ${_theme.id}');
    });
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyOfThemeId, _theme.id);
    dev.log('saved theme to shared prefs');
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        // Wrap our build in a future to wait for async shared prefs to load
        // before first rendering the UI.
        future: _restoreTheme(),
        builder: (context, snapshot) =>
            snapshot.hasData ? _buildWidget() : const SizedBox(),
      );

  Widget _buildWidget() {
    dev.log('buildWidget()');
    return Theme(
        data: _theme.theme,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          // TODO: this is pretty janky, passing the theme down.
          // Instead, we should be managing the app theme globally as in:
          // https://www.raywenderlich.com/16628777-theming-a-flutter-app-getting-started
          // Requires a bunch of refactoring though.
          body: BooksList(theme: _theme),
          floatingActionButton: FloatingActionButton(
            onPressed: _switchTheme,
            tooltip: 'Change Theme',
            child: const Icon(Icons.change_circle),
          ),
        ));
  }
}

class BooksList extends StatefulWidget {
  final _themes.WrappedTheme theme;

  const BooksList({required this.theme, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  _BooksListState() {
    dev.log('_BooksListState()');
  }

  final Future<List<BookModel>> futureHttp = makeHttpCall();

  @override
  Widget build(BuildContext context) => FutureBuilder<List<BookModel>>(
        // Wrap our build in a future to wait for async shared prefs to load
        // before first rendering the UI.
        future: futureHttp,
        builder: (context, snapshot) => snapshot.hasData
            ? _buildWidget(snapshot.data as List<BookModel>)
            : const SizedBox(),
      );

  Widget _buildWidget(List<BookModel> books) {
    return ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return BookCard(index, books[index], widget.theme);
        });
  }
}

class BookCard extends StatelessWidget {
  final int index;
  final BookModel book;
  final _themes.WrappedTheme theme;

  const BookCard(this.index, this.book, this.theme, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(
              context,
              '/details',
              arguments: NavigatorArgsWrapper(book, theme),
            ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        book.volumeInfo.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      book.volumeInfo.subtitle != null
                          ? Text(
                              '${book.volumeInfo.subtitle}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                            )
                          : const SizedBox(),
                      book.volumeInfo.authors != null
                          ? Text(
                              'Author(s): ${book.volumeInfo.authors?.join(", ")}',
                              style: const TextStyle(fontSize: 14),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                      maxHeight: 100,
                    ),
                    child: book.volumeInfo.imageLinks?.smallThumbnail != null
                        ? Image.network(
                            book.volumeInfo.imageLinks?.smallThumbnail
                                as String,
                            fit: BoxFit.fitHeight,
                          )
                        : Container())
              ],
            ),
          ),
        ));
  }
}
