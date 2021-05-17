import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:xodoracoes/login.dart';
import 'splashscreen.dart';


void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Xodó Rações',
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext context) => new Login()
      },
    );
  }
}




