import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatefulWidget {
  const MyTextFieldWidget({Key? key}) : super(key: key);

  @override
  State createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  late TextEditingController _controller;
  String userText = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent)
      ),
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Input text here:',
            style: Theme.of(context).textTheme.headline6,
          ),
          TextField(
              autofocus: false,
              controller: _controller,
              onSubmitted: (String value) async {
                setState(() {
                  userText = value;
                  _controller.clear();
                });
              }
          ),
          Text(
            userText,
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
