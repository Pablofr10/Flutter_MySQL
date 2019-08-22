import 'package:flutter/material.dart';

class VendedoresPage extends StatelessWidget {
  const VendedoresPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Vendas'),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Text('Estamos em Vendas'),
        ],
      ),
    );
  }
}