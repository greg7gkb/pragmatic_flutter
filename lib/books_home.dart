import 'themes.dart' as _themes;
import 'package:flutter/material.dart';

class BooksHome extends StatefulWidget {
  const BooksHome({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _BooksHomeState();
}

class _BooksHomeState extends State<BooksHome> {
  var theme = _themes.defaultTheme;

  void _switchTheme() {
    setState(() {
      theme = _themes.next(theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: theme,
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
