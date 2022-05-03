import 'bookmodel.dart';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

const apiKey = "AIzaSyDWKlFohuz7OzSbq2VAmiVSraK0k6JP6J4";

Future<List<BookModel>> makeHttpCall() async {
  Uri apiEndpoint = Uri.parse(
      "https://www.googleapis.com/books/v1/volumes?key=$apiKey&q=python");
  final http.Response response =
      await http.get(apiEndpoint, headers: {'Accept': 'application/json'});
  dev.log('http response: ' + response.toString());

  final jsonObject = json.decode(response.body);
  dev.log('json response: ' + jsonObject.toString());

  var list = jsonObject['items'] as List;
  return list.map((e) => BookModel.fromJson(e)).toList();
}
