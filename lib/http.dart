import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

const apiKey = "AIzaSyDWKlFohuz7OzSbq2VAmiVSraK0k6JP6J4";

Future<String> makeHttpCall() async {
  Uri apiEndpoint = Uri.parse(
      "https://www.googleapis.com/books/v1/volumes?key=$apiKey&q=python");
  final http.Response response =
      await http.get(apiEndpoint, headers: {'Accept': 'application/json'});
  dev.log(response.toString());
  return response.body;
}
