import 'package:flutter/material.dart';
import 'total.dart';
import 'dart:math';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  GlobalKey<TotalState> _keyTotal = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Random rng = new Random();
    double _valor = rng.nextInt(500) + 0.5;
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(primarySwatch: Colors.red),
        home: new Scaffold(
          body: new Total("USD", _valor, key: _keyTotal),
          floatingActionButton: new FloatingActionButton(
              child: new Icon(Icons.add),
              onPressed: () {
                _valor = rng.nextInt(500) + 0.5;
                _keyTotal.currentState.updateState(_valor);
              }),
        ));
  }
}
