/// To run in term:
/// clearr && flutter test test/widget_test.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_books/book_details_page.dart';
import 'package:hello_books/bookmodel.dart';
import 'package:hello_books/themes.dart' as _theme;
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  /// For widgets that must be wrapped in a MediaQuery ancestor so that
  /// exceptions aren't thrown during pump()
  Widget mockAppContext(Widget child) {
    return MaterialApp(home: child);
  }

  testWidgets('Book Details Page smoke test', (WidgetTester tester) async {
    final jsonObj = json.decode(jsonString);
    final book = BookModel.fromJson(jsonObj);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(mockAppContext(
          BookDetailsPage(book: book, theme: _theme.defaultTheme)));

      // debugDumpApp();

      // Verify that screen loads.
      const String title = 'Automate the Boring Stuff with Python, 2nd Edition';
      expect(
          find.text(title),
          // This is pretty annoying - in debug, for unknown reasons, Text() renders with a child RichText() component
          findsNWidgets(2));
      var titleWidget = find.text(title).evaluate().first.widget as Text;

      // Verify default theme is applied
      expect(titleWidget.style?.color, Colors.pink);
    });
  });
}

const String jsonString = '''{
  "kind": "books#volume",
  "id": "RQ6xDwAAQBAJ",
  "etag": "/X+84mLchXg",
  "selfLink": "https://www.googleapis.com/books/v1/volumes/RQ6xDwAAQBAJ",
  "volumeInfo": {
    "title": "Automate the Boring Stuff with Python, 2nd Edition",
    "subtitle": "Practical Programming for Total Beginners",
    "authors": [
      "Al Sweigart"
    ],
    "publisher": "No Starch Press",
    "publishedDate": "2019-11-12",
    "description": "The second edition of this best-selling Python book (over 500,000 copies sold!) uses Python 3 to teach even the technically uninclined how to write programs that do in minutes what would take hours to do by hand. There is no prior programming experience required and the book is loved by liberal arts majors and geeks alike. If you've ever spent hours renaming files or updating hundreds of spreadsheet cells, you know how tedious tasks like these can be. But what if you could have your computer do them for you? In this fully revised second edition of the best-selling classic Automate the Boring Stuff with Python, you'll learn how to use Python to write programs that do in minutes what would take you hours to do by hand--no prior programming experience required. You'll learn the basics of Python and explore Python's rich library of modules for performing specific tasks, like scraping data off websites, reading PDF and Word documents, and automating clicking and typing tasks. The second edition of this international fan favorite includes a brand-new chapter on input validation, as well as tutorials on automating Gmail and Google Sheets, plus tips on automatically updating CSV files. You'll learn how to create programs that effortlessly perform useful feats of automation to: • Search for text in a file or across multiple files • Create, update, move, and rename files and folders • Search the Web and download online content • Update and format data in Excel spreadsheets of any size • Split, merge, watermark, and encrypt PDFs • Send email responses and text notifications • Fill out online forms Step-by-step instructions walk you through each program, and updated practice projects at the end of each chapter challenge you to improve those programs and use your newfound skills to automate similar tasks. Don't spend your time doing work a well-trained monkey could do. Even if you've never written a line of code, you can make your computer do the grunt work. Learn how in Automate the Boring Stuff with Python, 2nd Edition.",
    "industryIdentifiers": [
      {
        "type": "ISBN_13",
        "identifier": "9781593279936"
      },
      {
        "type": "ISBN_10",
        "identifier": "1593279930"
      }
    ],
    "readingModes": {
      "text": true,
      "image": false
    },
    "pageCount": 592,
    "printType": "BOOK",
    "categories": [
      "Computers"
    ],
    "averageRating": 4.5,
    "ratingsCount": 2,
    "maturityRating": "NOT_MATURE",
    "allowAnonLogging": true,
    "contentVersion": "1.2.2.0.preview.2",
    "panelizationSummary": {
      "containsEpubBubbles": false,
      "containsImageBubbles": false
    },
    "imageLinks": {
      "smallThumbnail": "http://books.google.com/books/content?id=RQ6xDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
      "thumbnail": "http://books.google.com/books/content?id=RQ6xDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
    },
    "language": "en",
    "previewLink": "http://books.google.com/books?id=RQ6xDwAAQBAJ&printsec=frontcover&dq=python&hl=&cd=1&source=gbs_api",
    "infoLink": "https://play.google.com/store/books/details?id=RQ6xDwAAQBAJ&source=gbs_api",
    "canonicalVolumeLink": "https://play.google.com/store/books/details?id=RQ6xDwAAQBAJ"
  },
  "saleInfo": {
    "country": "US",
    "saleability": "FOR_SALE",
    "isEbook": true,
    "listPrice": {
      "amount": 23.99,
      "currencyCode": "USD"
    },
    "retailPrice": {
      "amount": 23.99,
      "currencyCode": "USD"
    },
    "buyLink": "https://play.google.com/store/books/details?id=RQ6xDwAAQBAJ&rdid=book-RQ6xDwAAQBAJ&rdot=1&source=gbs_api",
    "offers": [
      {
        "finskyOfferType": 1,
        "listPrice": {
          "amountInMicros": 23990000,
          "currencyCode": "USD"
        },
        "retailPrice": {
          "amountInMicros": 23990000,
          "currencyCode": "USD"
        },
        "giftable": true
      }
    ]
  },
  "accessInfo": {
    "country": "US",
    "viewability": "PARTIAL",
    "embeddable": true,
    "publicDomain": false,
    "textToSpeechPermission": "ALLOWED",
    "epub": {
      "isAvailable": true
    },
    "pdf": {
      "isAvailable": false
    },
    "webReaderLink": "http://play.google.com/books/reader?id=RQ6xDwAAQBAJ&hl=&printsec=frontcover&source=gbs_api",
    "accessViewStatus": "SAMPLE",
    "quoteSharingAllowed": false
  },
  "searchInfo": {
    "textSnippet": "The second edition of this international fan favorite includes a brand-new chapter on input validation, Gmail and Google Sheets automations, tips for updating CSV files, and more."
  }
}''';
