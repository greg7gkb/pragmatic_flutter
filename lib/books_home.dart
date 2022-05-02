import 'dart:developer' as dev;
import 'themes.dart' as _themes;
import 'http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late Future<List<bool>> _futures;

  Future<bool> _restoreTheme() async {
    var prefs = await SharedPreferences.getInstance();
    var val = prefs.getInt(keyOfThemeId);
    if (val != null) {
      _theme = _themes.getById(val);
      dev.log('loaded theme of id: ${_theme.id}');
    }
    return true;
  }

  Future<bool> _makeHttpCall() async {
    var rtn = await makeHttpCall();
    dev.log('http response: $rtn');
    return true;
  }

  @override
  void initState() {
    super.initState();
    dev.log('initState(), theme: ${_theme.id}');

    _futures = Future.wait([
      _restoreTheme(),
      _makeHttpCall(),
    ]);
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
        future: _futures,
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
          body: const BooksList(),
          floatingActionButton: FloatingActionButton(
            onPressed: _switchTheme,
            tooltip: 'Change Theme',
            child: const Icon(Icons.change_circle),
          ),
        ));
  }
}

List fetchBookData() {
  return [
    {
      'title': 'Book Title',
      'authors': ['Author1', 'Author2'],
      'image': 'assets/books_icon.webp'
    },
    {
      'title': 'Book Title 2',
      'authors': ['Author1'],
      'image': null,
    },
    {
      'title': 'Book Title 3',
      'authors': ['Author1', 'Author2'],
      'image': 'assets/books_icon.webp'
    },
  ];
}

final booksListing = fetchBookData();

class BooksList extends StatelessWidget {
  const BooksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: booksListing.length,
        itemBuilder: (context, index) {
          return BookCard(index);
        });
  }
}

class BookCard extends StatelessWidget {
  final int index;

  const BookCard(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    '${booksListing[index]['title']}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  booksListing[index]['authors'] != null
                      ? Text(
                          'Author(s): ${booksListing[index]['authors'].join(", ")}',
                          style: const TextStyle(fontSize: 14),
                        )
                      : const Text(""),
                ],
              ),
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 100,
                  maxHeight: 100,
                ),
                child: booksListing[index]['image'] != null
                    ? Image.asset(
                        booksListing[index]['image'],
                        fit: BoxFit.fitHeight,
                      )
                    : Container())
          ],
        ),
      ),
    );
  }
}
