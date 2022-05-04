/*
Clone of file in book's source code repo:
https://github.com/ptyagicodecamp/pragmatic_flutter/blob/master/lib/chapter15/book_details_page.dart
 */
import 'bookmodel.dart';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:hello_books/themes.dart';
import 'package:url_launcher/url_launcher.dart';

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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InformationWidget(
                      book: book,
                    ),
                    ActionsWidget(
                      book: book,
                    ),
                    DescriptionWidget(
                      book: book,
                    ),
                  ],
                ),
              ),
            )));
  }
}

class InformationWidget extends StatelessWidget {
  final BookModel book;

  const InformationWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                book.volumeInfo.title,
                style:
                    TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
              ),
              book.volumeInfo.subtitle != null
                  ? Text(
                      '${book.volumeInfo.subtitle}',
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 14),
                    )
                  : Container(),
              book.volumeInfo.authors != null
                  ? Text(
                      'Author(s): ${book.volumeInfo.authors?.join(", ")}',
                      style: const TextStyle(fontSize: 14),
                    )
                  : Container(),
              book.volumeInfo.publisher != null
                  ? Text(
                      "Published by: ${book.volumeInfo.publisher}",
                      style: const TextStyle(
                          fontSize: 14, fontStyle: FontStyle.italic),
                    )
                  : Container(),
              book.volumeInfo.publishedDate != null
                  ? Text(
                      "Published on: ${book.volumeInfo.publishedDate}",
                      style: const TextStyle(
                          fontSize: 14, fontStyle: FontStyle.italic),
                    )
                  : Container(),
            ],
          ),
        ),
        book.volumeInfo.imageLinks?.thumbnail != null
            ? Image.network(
                book.volumeInfo.imageLinks?.thumbnail as String,
                fit: BoxFit.fill,
              )
            : Container(),
      ],
    );
  }
}

class ActionsWidget extends StatelessWidget {
  final BookModel book;

  const ActionsWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          book.accessInfo.webReaderLink != null
              ? FloatingActionButton.extended(
                  label: const Text("Read"),
                  heroTag: "webReaderLink",
                  onPressed: () => launchUrl(
                      Uri.parse(book.accessInfo.webReaderLink as String)),
                )
              : Container(),
          book.saleInfo.saleability == "FOR_SALE"
              ? FloatingActionButton.extended(
                  label: const Text("Buy"),
                  heroTag: "buy_book",
                  onPressed: () =>
                      launchUrl(Uri.parse(book.saleInfo.buyLink as String)),
                )
              : Container(),
        ],
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final BookModel book;

  const DescriptionWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return book.volumeInfo.description != null
        ? Text(book.volumeInfo.description.toString())
        : Container();
  }
}
