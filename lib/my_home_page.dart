import 'package:flutter/material.dart';

import 'my_text_field_widget.dart';
import 'my_future_with_placeholder.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter(BuildContext context) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });

    if (_counter == 3) {
      showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showRemoteImage(),
            Text(
              'You have pushed the button this many times:',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const MyTextFieldWidget(),
            const MyFutureWithPlaceholderWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { _incrementCounter(context); },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget showRemoteImage() {
    const double d = 250;
    return Container(
        width: d,
        height: d,
        padding: const EdgeInsets.all(20),
        child: Image.network("https://static.scientificamerican.com/sciam/cache/file/1DDFE633-2B85-468D-B28D05ADAE7D1AD8_source.jpg?w=590&h=800")
    );
  }

  Future<void> showAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Alert Dialog"),
            content: const Text('I\'m an alert widget'),
            actions: <Widget>[
              TextButton(onPressed: () { Navigator.of(context).pop(); }, child: const Text('Cancel')),
              TextButton(onPressed: () { Navigator.of(context).pop(); }, child: const Text('OK')),
            ],
          );
        }
    );
  }
}
