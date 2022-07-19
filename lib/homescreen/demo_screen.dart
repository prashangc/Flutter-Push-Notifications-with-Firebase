import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  static const routeName = "/demo-screen";
  final id;
  const DemoScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id.toString()),
      ),
    );
  }
}
