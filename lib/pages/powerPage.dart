import 'package:flutter/material.dart';

class PowerPage extends StatelessWidget {
  const PowerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Power'),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Text('Estamos em Power'),
        ],
      ),
    );
  }
}