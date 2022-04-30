import 'package:flutter/material.dart';

class MyFutureWithPlaceholderWidget extends StatefulWidget {
  const MyFutureWithPlaceholderWidget({Key? key}) : super(key: key);

  @override
  State createState() => _MyFutureBuilderWidgetState();
}

class _MyFutureBuilderWidgetState extends State<MyFutureWithPlaceholderWidget> {
  // final Future<int> _futureData = Future<int>.delayed(
  //     const Duration(seconds: 3), () => 2468);
  final Future<String> _futureError = Future<String>.delayed(
      const Duration(seconds: 3), () => throw ("Sample throwable error"));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _futureError,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        Widget futureChild;
        if (snapshot.hasData) {
          //success
          futureChild = Text("Number received is: ${snapshot.data}");
        } else if (snapshot.hasError) {
          //show error message
          futureChild = Text("Error occurred fetching data: [${snapshot.error}]");
        } else {
          //waiting for data to arrive
          futureChild = const CircularProgressIndicator();
        }

        return futureChild;
      }
    );
  }
}
